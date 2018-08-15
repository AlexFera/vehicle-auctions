using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

namespace Infrastructure.Identity
{
    public static class AppIdentityDbContextSeed
    {
        public static async Task SeedAsync(UserManager<ApplicationUser> userManager)
        {
            var defaultUser = new ApplicationUser { UserName = "alex@mailinator.com", Email = "alex@mailinator.com" };
            await userManager.CreateAsync(defaultUser, "Pass@word1");

            var vendorRomania = new ApplicationUser { UserName = "vendor-romania@mailinator.com", Email = "vendor-romania@mailinator.com" };
            await userManager.CreateAsync(vendorRomania, "Pass@word1");

            var vendorSpain = new ApplicationUser { UserName = "vendor-spain@mailinator.com", Email = "vendor-spain@mailinator.com" };
            await userManager.CreateAsync(vendorSpain, "Pass@word1");

            var vendorUnitedKingdom = new ApplicationUser { UserName = "vendor-united-kingdom@mailinator.com", Email = "vendor-united-kingdom@mailinator.com" };
            await userManager.CreateAsync(vendorUnitedKingdom, "Pass@word1");

            var andreeaUser = new ApplicationUser { UserName = "andreea@mailinator.com", Email = "andreea@mailinator.com" };
            await userManager.CreateAsync(andreeaUser, "Pass@word1");

            var tomUser = new ApplicationUser { UserName = "tom@mailinator.com", Email = "tom@mailinator.com" };
            await userManager.CreateAsync(tomUser, "Pass@word1");

            var sofiaUser = new ApplicationUser { UserName = "sofia@mailinator.com", Email = "sofia@mailinator.com" };
            await userManager.CreateAsync(sofiaUser, "Pass@word1");
        }
    }
}
