using Microsoft.EntityFrameworkCore;
using BankAPI.Data;
using BankAPI.Data.BankModels;
using TestBankAPI.Data.DTOs;
using BankAPI.Data.DTOs;

namespace BankAPI.Services;

public class BankTransactionService {
    private readonly BankContext _context;
    private readonly AccountService _accountService;

    public BankTransactionService(BankContext context, AccountService accountService) {

        _context = context;
        _accountService = accountService;

    }

    public async Task<IEnumerable<AccountDtoOut>> GetAll(string email) {

        var client = await _context.Clients.SingleOrDefaultAsync(c => c.Email == email);

        if (client is null) {

            return new List<AccountDtoOut>();

        }

        return await _context.Accounts
            .Where(a => a.ClientId == client.Id)
            .Select(a => new AccountDtoOut

            {

                Id = a.Id,
                AccountName = a.AccountTypeNavigation.Name,
                ClientName = a.Client != null ? a.Client.Name : "",
                Balance = a.Balance,
                RegDate = a.RegDate

            }).ToListAsync();
    }

    public async Task<string> Withdraw(string email, WithdrawDto withdrawDto) {

        var client = await _context.Clients.SingleOrDefaultAsync(c => c.Email == email);

        if (client is null) {

            return "Cliente no encontrado.";

        }

        var account = await _accountService.GetById(withdrawDto.AccountId);

        if (account is null || account.ClientId != client.Id) {

            return "Cuenta no encontrada.";

        }

        if (withdrawDto.Amount <= 0) {

            return "El monto debe ser mayor que cero.";

        }

        if (account.Balance < withdrawDto.Amount) {

            return "Saldo insuficiente.";

        }

        account.Balance -= withdrawDto.Amount;

        var bankTransaction = new BankTransaction {

            AccountId = withdrawDto.AccountId,
            TransactionType = 1, 
            Amount = withdrawDto.Amount,
            ExternalAccountId = withdrawDto.ExternalAccountId
        };

        _context.BankTransactions.Add(bankTransaction);
        await _context.SaveChangesAsync();
        return "Valid";

    }

    public async Task<string> Deposit(string email, DepositDto depositDto) {

        var client = await _context.Clients.SingleOrDefaultAsync(c => c.Email == email);

        if (client is null) {
            return "Cliente no encontrado.";

        }

        var account = await _accountService.GetById(depositDto.AccountId);
        if (account is null || account.ClientId != client.Id) {

            return "Cuenta no encontrada.";
        }

        if (depositDto.Amount <= 0) {

            return "El monto debe ser mayor que cero.";
        }

        account.Balance += depositDto.Amount;
        var bankTransaction = new BankTransaction {

            AccountId = depositDto.AccountId,
            TransactionType = 2, 
            Amount = depositDto.Amount

        };

       _context.BankTransactions.Add(bankTransaction);
       await _context.SaveChangesAsync();
       return "Valid";
   }

   public async Task<string> Delete(string email, int accountId) {

       var client = await _context.Clients.SingleOrDefaultAsync(c => c.Email == email);

       if (client is null) {

           return "Cliente no encontrado.";
       }

       var account = await _accountService.GetById(accountId);

       if (account is null || account.ClientId != client.Id) {

           return "Cuenta no encontrada.";
       }

       if (account.Balance > 0) {

           return "La cuenta aún tiene saldo.";
       }

      await _accountService.Delete(accountId);
      return "Valid";

   }
   
}
