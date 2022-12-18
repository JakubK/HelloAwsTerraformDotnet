using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.Lambda.Core;
using Amazon.Lambda.DynamoDBEvents;
using Amazon.Lambda.RuntimeSupport;
using Amazon.Lambda.Serialization.SystemTextJson;
using StackExchange.Redis;


namespace StreamHandler;

public class Function
{
    private static IConnectionMultiplexer _connectionMultiplexer;

    private static readonly string RedisConnectionString = Environment.GetEnvironmentVariable("RedisConnectionString")!;

    static async Task Main(string[] args)
    {
        _connectionMultiplexer = await ConnectionMultiplexer.ConnectAsync(RedisConnectionString);
        var handler = FunctionHandlerAsync;
        await LambdaBootstrapBuilder.Create(handler, new DefaultLambdaJsonSerializer())
            .Build()
            .RunAsync();
    }
    
    static async Task FunctionHandlerAsync(DynamoDBEvent dynamoEvent, ILambdaContext context)
    {
        context.Logger.LogInformation($"Beginning to process {dynamoEvent.Records.Count} records...");
        var cache = _connectionMultiplexer.GetDatabase();
        foreach (var record in dynamoEvent.Records)
        {
            if (record.EventName == OperationType.REMOVE)
            {
                var deleteId = record.Dynamodb.OldImage["id"].S;
                await cache.KeyDeleteAsync(deleteId);
                continue;
            }

            var recordAsDocument = Document.FromAttributeMap(record.Dynamodb.NewImage);
            var json = recordAsDocument.ToJson();
            var id = record.Dynamodb.NewImage["id"].S;
            await cache.StringSetAsync(id, json);
        }
        context.Logger.LogLine($"Completed handling {dynamoEvent.Records.Count} documents");
    }
}