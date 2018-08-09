using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

namespace Infrastructure.Identity
{
    public static class AppIdentityDbContextSeed
    {
        public static async Task SeedAsync(UserManager<ApplicationUser> userManager)
        {
            var defaultUser = new ApplicationUser { UserName = "demouser-vehicleauctions@mailinator.com", Email = "demouser-vehicleauctions@mailinator.com" };
            await userManager.CreateAsync(defaultUser, "Pass@word1").ConfigureAwait(false);
        }
    }
}
