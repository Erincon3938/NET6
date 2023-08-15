namespace BankAPI.Data.DTOs;

public class WithdrawDto {
    
    public int AccountId { get; set; }
    public decimal Amount { get; set; }
    public int? ExternalAccountId { get; set; }

}

