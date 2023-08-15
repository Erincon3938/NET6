#nullable disable
using Microsoft.AspNetCore.Mvc;
using BankAPI.Services;
using BankAPI.Data.DTOs;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using BankAPI.Data.BankModels;

namespace BankAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ClientLoginController : ControllerBase {
    private readonly ClientService _clientService;
    private readonly IConfiguration _config;

    public ClientLoginController(ClientService clientService, IConfiguration config) {

        _clientService = clientService;
        _config = config;

    }

    [HttpPost("login")]
    public async Task<IActionResult> ClientLogin(ClientDto clientDto) {

        var client = await _clientService.GetClient(clientDto);

        if (client is null) {

            return BadRequest(new { message = "Credenciales Inválidas." });
            
        }

        string jwtToken = GenerarToken(client);
        return Ok(new { token = jwtToken });
    }

    private string GenerarToken(Client client) {

        var claims = new[] { new Claim(ClaimTypes.Name, client.Name), new Claim(ClaimTypes.Email, client.Email) };
        var jwtKey = _config.GetSection("JWT:Key").Value;
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);
        var securityToken = new JwtSecurityToken(claims: claims, expires: DateTime.Now.AddMinutes(60), signingCredentials: creds);
        string token = new JwtSecurityTokenHandler().WriteToken(securityToken);
        return token;

    }
}

