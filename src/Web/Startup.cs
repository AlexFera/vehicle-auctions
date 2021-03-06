﻿using Core.Interfaces;
using Core.Services;
using Infrastructure.Data;
using Infrastructure.ElasticScale;
using Infrastructure.Identity;
using Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using Web.Hubs;

namespace Web
{
    public class Startup
    {
        private IServiceCollection services;

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // Add Identity DbContext
            services.AddDbContext<AppIdentityDbContext>(options =>
                options.UseSqlServer(Configuration.GetConnectionString("MainConnection")));

            services.AddIdentity<ApplicationUser, IdentityRole>(config => { config.SignIn.RequireConfirmedEmail = true; })
              .AddEntityFrameworkStores<AppIdentityDbContext>()
              .AddDefaultTokenProviders();

            services.ConfigureApplicationCookie(options =>
            {
                options.Cookie.HttpOnly = true;
                options.ExpireTimeSpan = TimeSpan.FromHours(1);
                options.LoginPath = "/Account/Signin";
                options.LogoutPath = "/Account/Signout";
                options.Cookie = new CookieBuilder
                {
                    IsEssential = true
                };
            });

            services.AddScoped<ISaleRepository, SaleRepository>();
            services.AddScoped<ILotRepository, LotRepository>();
            services.AddScoped<IBidRepository, BidRepository>();
            services.AddScoped<IAuctionService, AuctionService>();
            services.AddSingleton(CreateOrGetShardMapManager(Configuration));
            services.AddScoped<IElasticScaleClient, ElasticScaleClient>();

            var requireAuthenticatedUserPolicy = new AuthorizationPolicyBuilder()
                     .RequireAuthenticatedUser()
                     .Build();

            services.AddMvc(config => config.Filters.Add(new AuthorizeFilter(requireAuthenticatedUserPolicy))).SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            services.AddSignalR();

            this.services = services;
        }

        public void ConfigureDevelopmentServices(IServiceCollection services)
        {
            ConfigureServices(services);
        }

        public void ConfigureProductionServices(IServiceCollection services)
        {
            ConfigureServices(services);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
#pragma warning disable CA1822 // Mark members as static
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
#pragma warning restore CA1822 // Mark members as static
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseAuthentication();

            app.UseSignalR(routes =>
            {
                routes.MapHub<BiddingHub>("/biddingHub");
            });
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }

        private static ShardMapManager CreateOrGetShardMapManager(IConfiguration configuration)
        {
            var shardMapManagerConnection = configuration.GetConnectionString("ShardMapManagerConnection");
            var shardMapManagerExists = ShardMapManagerFactory.TryGetSqlShardMapManager(shardMapManagerConnection, ShardMapManagerLoadPolicy.Lazy, out ShardMapManager shardMapManager);

            if (!shardMapManagerExists)
            {
                shardMapManager = ShardMapManagerFactory.CreateSqlShardMapManager(shardMapManagerConnection);
            }

            return shardMapManager;
        }
    }
}
