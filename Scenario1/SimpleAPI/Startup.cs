using Amazon.DynamoDBv2;
using SimpleAPI.Repositories;
using SimpleAPI.Services;
using StackExchange.Redis;

namespace SimpleAPI;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddSwaggerGen();
        services.AddSingleton<IAmazonDynamoDB>(_ => new AmazonDynamoDBClient());
        services.AddSingleton<IConnectionMultiplexer>(_ => ConnectionMultiplexer.Connect(Configuration.GetValue<string>("Redis:ConnectionString")));
        services.AddSingleton<IProductRepository>(x =>
            new ProductRepository(
                x.GetRequiredService<IAmazonDynamoDB>(),
                x.GetRequiredService<IConnectionMultiplexer>(), Configuration.GetValue<string>("DynamoDb:TableName")));
        services.AddSingleton<IProductService, ProductService>();
        
        
        services.AddControllers();
        services.AddAWSLambdaHosting(LambdaEventSource.HttpApi);
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }
        
        app.UseSwagger();
        app.UseSwaggerUI();
        app.UseHttpsRedirection();
        app.UseRouting();

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
            endpoints.MapGet("/", async context =>
            {
                await context.Response.WriteAsync("Welcome to running ASP.NET Core on AWS Lambda");
            });
        });
    }
}