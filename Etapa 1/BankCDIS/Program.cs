using System;

class Program {
    static void Main() {
        int[] bills = { 500, 200, 100, 50, 20 };
        int[] coins = { 10, 5, 1 };
        int[] withdrawals = new int[10];
        int numWithdrawals = 0;

        while (true) {

            Console.Clear();
            Console.WriteLine("----------------------- Banco CDIS ----------------------");
            Console.WriteLine("1. Ingresar la cantidad de retiros hechos por los usuarios.");
            Console.WriteLine("2. Revisar la cantidad entregada de billetes y monedas.");
            Console.Write("\nIngresa la opción:");

            int option;

            if (!int.TryParse(Console.ReadLine(), out option)) {

                Console.WriteLine("Opción inválida. Presiona 'enter' para continuar ...");
                Console.ReadLine();
                continue;

            }

            switch (option) {

                case 1:

                    numWithdrawals = EnterWithdrawals(withdrawals);
                    break;

                case 2:

                    ShowBillsCoinsQuantity(withdrawals, numWithdrawals, bills, coins);
                    break;

                default:

                    Console.WriteLine("Opción inválida. Presiona 'enter' para continuar ...");
                    Console.ReadLine();
                    break;
            }

        }

    }

    static int EnterWithdrawals(int[] withdrawals) {

        Console.Write("\n¿Cuántos retiros se hicieron (máximo 10)? ");
        int numWithdrawals;

        if (!int.TryParse(Console.ReadLine(), out numWithdrawals) || numWithdrawals <= 0 || numWithdrawals > 10) {

            Console.WriteLine("Cantidad de retiros inválida. Presiona 'enter' para continuar ...");
            Console.ReadLine();
            return 0;

        }

        for (int i = 0; i < numWithdrawals; i++) {

            Console.Write($"\nIngresa la cantidad del retiro #{i + 1}: ");
            int withdrawalAmount;

            if (!int.TryParse(Console.ReadLine(), out withdrawalAmount) || withdrawalAmount <= 0 || withdrawalAmount > 50000) {

                Console.WriteLine("Cantidad de retiro inválida. Presiona 'enter' para continuar ...");
                Console.ReadLine();
                return 0;

            }

            withdrawals[i] = withdrawalAmount;
        }

        return numWithdrawals;

    }

    static void ShowBillsCoinsQuantity(int[] withdrawals, int numWithdrawals, int[] bills, int[] coins) {

        if (numWithdrawals == 0) {

            Console.WriteLine("Aún no se han ingresado retiros. Presiona 'enter' para continuar ...");
            Console.ReadLine();
            return;

        }

        for (int i = 0; i < numWithdrawals; i++) {

            Console.WriteLine($"Retiro #{i + 1}:\n");
            CalculateBillsCoins(withdrawals[i], bills, coins);
            Console.WriteLine();

        }

        Console.WriteLine("Presiona 'enter' para continuar ...");
        Console.ReadLine();
    }

    static void CalculateBillsCoins(int amount, int[] bills, int[] coins) {

        int remainingAmount = amount;
        int totalBills = 0;
        int totalCoins = 0;


        foreach (int bill in bills) {

            int billQuantity = remainingAmount / bill;
            remainingAmount %= bill;
            totalBills += billQuantity;

        }

        foreach (int coin in coins) {

            int coinQuantity = remainingAmount / coin;
            remainingAmount %= coin;
            totalCoins += coinQuantity;

        }

        Console.WriteLine($"Total de billetes entregados: {totalBills}");
        Console.WriteLine();

        remainingAmount = amount;

        Console.WriteLine("Billetes entregados:");

        foreach (int bill in bills) {

            int billQuantity = remainingAmount / bill;
            remainingAmount %= bill;

            if (billQuantity > 0) {

                Console.WriteLine($"{billQuantity} billete(s) de ${bill} = ${billQuantity * bill}");

            }

        }

        Console.WriteLine();
        Console.WriteLine($"Total de monedas entregadas: {totalCoins}");
        Console.WriteLine();

        Console.WriteLine("Monedas entregadas:");

        foreach (int coin in coins) {

            int coinQuantity = remainingAmount / coin;
            remainingAmount %= coin;

            if (coinQuantity > 0) {

                Console.WriteLine($"{coinQuantity} moneda(s) de ${coin} = ${coinQuantity * coin}");

            }

        }
        
    }

}