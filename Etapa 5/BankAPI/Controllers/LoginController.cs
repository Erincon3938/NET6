#nullable disable
using Microsoft.AspNetCore.Mvc;
using BankAPI.Services;
using BankAPI.Data.DTOs;
using BankAPI.Data.BankModels;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;


namespace BankAPI.Controllers;

[ ApiController ]
[Route("api/[controller]")]

public class LoginController : ControllerBase {


    private IConfiguration config;

    private readonly LoginService loginService;

    
    public LoginController (LoginService loginService, IConfiguration config) {

        this.loginService = loginService;
        this.config = config;
        
    }

    [HttpPost("authenticate")]
    public async Task < IActionResult > Login (AdminDto adminDto) {

        var admin = await loginService.GetAdmin(adminDto);

        if (admin is  null) {

            return BadRequest( new { message = "Credenciales Inválidas."});
        }

        string jwtToken = GenerarToken(admin);

        return Ok( new{ token = jwtToken } ) ;

    }

    private string GenerarToken(Administrator admin) {

        var claims = new [] {

            new Claim(ClaimTypes.Name, admin.Name),
            new Claim(ClaimTypes.Email, admin.Email),
            new Claim("AdminType" , admin.AdminType)

        };

        var jwtKey = config.GetSection("JWT:Key").Value;

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));

        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

        var securityToken = new JwtSecurityToken(

                            claims : claims,
                            expires : DateTime.Now.AddMinutes(60),
                            signingCredentials : creds

                        ) ;

        string token = new JwtSecurityTokenHandler().WriteToken(securityToken);

        return token;

    }
 
}