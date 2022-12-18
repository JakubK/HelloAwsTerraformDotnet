using SimpleAPI.Data;

namespace SimpleAPI.Repositories;

public interface IProductRepository
{
    Task<ProductDto?> GetByIdAsync(Guid productId);

    Task<ProductDto> CreateAsync(ProductDto product);

    Task<ProductDto> UpdateAsync(ProductDto updatedProduct);

    Task<bool> DeleteAsync(Guid productId);
}