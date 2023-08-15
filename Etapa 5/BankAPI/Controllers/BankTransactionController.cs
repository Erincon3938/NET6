#nullable disable
using Microsoft.AspNetCore.Mvc;
using BankAPI.Services;
using TestBankAPI.Data.DTOs;
using Microsoft.AspNetCore.Authorization;
using BankAPI.Data.DTOs;
using System.Security.Claims;

namespace BankAPI.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class BankTransactionController : ControllerBase {
    private readonly BankTransactionService _bankTransactionService;
    private readonly AccountService _accountService;

    public BankTransactionController(BankTransactionService bankTransactionService, AccountService accountService) {

        _bankTransactionService = bankTransactionService;
        _accountService = accountService;
    }

    [HttpGet("getall")]
    public async Task<IEnumerable<AccountDtoOut>> Get() {

        var email = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
        return await _bankTransactionService.GetAll(email);

    }

    [HttpPost("withdraw")]
    public async Task<IActionResult> Withdraw(WithdrawDto withdrawDto) {
        
        var email = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
        var result = await _bankTransactionService.Withdraw(email, withdrawDto);

        if (!result.Equals("Valid")) {

            return BadRequest(new { message = result });

        }

        return Ok();

    }

    [HttpPost("deposit")]
    public async Task<IActionResult> Deposit(DepositDto depositDto) {

        var email = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
        var result = await _bankTransactionService.Deposit(email, depositDto);
        if (!result.Equals("Valid")) {

            return BadRequest(new { message = result });

        }
        return Ok();

    }

    [HttpDelete("delete/{id}")]
    public async Task<IActionResult> Delete(int id) {

        var email = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
        var result = await _bankTransactionService.Delete(email, id);
        if (!result.Equals("Valid")) {

            return BadRequest(new { message = result });

        }

        return Ok();

    }
    
}

