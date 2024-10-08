﻿

using Microsoft.AspNetCore.Authentication.Cookies;
using SV21T1020885.Web.AppCodes;

var builder = WebApplication.CreateBuilder(args);

// Add các Service cần dùng trong Application
builder.Services.AddHttpContextAccessor();

// Add services to the container.
builder.Services.AddControllersWithViews()
        .AddMvcOptions(option =>
        {
            option.SuppressImplicitRequiredAttributeForNonNullableReferenceTypes = true;
        });

builder.Services.AddSession(option =>
{
    option.IdleTimeout = TimeSpan.FromMinutes(60);
    option.Cookie.HttpOnly = true;
    option.Cookie.IsEssential = true;
});

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(option =>
                {
                    option.Cookie.Name = "AuthenticationCookie";
                    option.LoginPath = "/Account/Login";
                    option.AccessDeniedPath = "/Account/AccessDenied";
                    option.ExpireTimeSpan = TimeSpan.FromDays(360);
                });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();
app.UseSession(); // Session middleware

app.UseRouting();

app.UseAuthentication(); // Authentication middleware
app.UseAuthorization();  // Authorization middleware

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

ApplicationContext.Configure(
    httpContextAccessor: app.Services.GetRequiredService<IHttpContextAccessor>(),
    hostEnvironment: app.Services.GetRequiredService<IWebHostEnvironment>()
);

string connectionString = @"server=.\SA;user=sa;password=123;database=LiteCommerceDB;TrustServerCertificate=true";
SV21T1020885.BusinessLayers.Configuration.Initialize(connectionString);

app.Run();

