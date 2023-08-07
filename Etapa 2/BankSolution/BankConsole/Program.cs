using BankConsole;

if (args.Length == 0) {

    //EmailService.SendEmail();
    ShowMenu();

}

else {

    ShowMenu();

}

void ShowMenu() {

    Console.Clear();
    Console.WriteLine("Seleccione una opción:");
    Console.WriteLine("\n1 - Crear un Usuario Nuevo.");
    Console.WriteLine("\n2 - Eliminar un Usuario Existente.");
    Console.WriteLine("\n3 - Salir");

    int option = 0;

    do {

        Console.Write("\nIngrese su opción: ");

        string input = Console.ReadLine();

        if (!int.TryParse(input, out option)) {

            Console.WriteLine("Debes de inresar un número (1 o 2 o 3).");

        }

        else if (option > 3) {

            Console.WriteLine("Debes de inresar un número valido (1 o 2 o 3).");
        }

    } while (option == 0 || option >3);

    switch (option) {

        case 1:

            CreateUser();
            break;

        case 2:

            DeleteUser();
            break;

        case 3: 

            Environment.Exit(0);
            break;
    }

}

void CreateUser() {

    Console.Clear();
    Console.WriteLine("Ingresa la información del usuario:");

    Console.Write("\nID: ");
    int ID = int.Parse(Console.ReadLine());


    bool validID = false;

    while (!validID) {

        if ( ID < 0) {

            Console.WriteLine("\nEl ID debe ser un entero positivo.");
            Console.Write("\nID: ");
            ID = int.Parse(Console.ReadLine());
        }

        else if (Storage.GetUsers().Any(u => u.GetID() == ID)) {

            Console.WriteLine("\nEl ID ingresado ya existe.");
            Console.Write("\nID: ");
            ID = int.Parse(Console.ReadLine());

        }

        else {

            validID = true;
        }

    }


    Console.Write("\nNombre: "); 
    string name = Console.ReadLine();

    Console.Write("\nEmail: "); 
    string email = Console.ReadLine();

    bool validEmail = false;

    while(!validEmail) {

        try {

            var add = new System.Net.Mail.MailAddress(email);
            validEmail = add.Address == email;
        }

        catch {

            Console.Write("\nEl email es invalido.");
            Console.Write("\nEmail: "); 
            email = Console.ReadLine();

        }

    }

    Console.Write("\nSaldo: "); 
    decimal balance = decimal.Parse(Console.ReadLine());

    while (balance < 0) {

        Console.WriteLine("\nEl saldo debe ser un decimal positivo.");
        Console.Write("\nSaldo: ");
        balance = decimal.Parse(Console.ReadLine());

    }

    Console.Write("\nEscribe 'c' si el usuario es Cliente, 'e' si es Empleado: "); 
    char userType = char.Parse(Console.ReadLine());

    while (userType != 'c' && userType != 'e') {

        Console.WriteLine("\nDebes ingresar 'c' si el usuario es Cliente o 'e' si es Empleado.");
        Console.Write("\nEscribe 'c' si el usuario es Cliente, 'e' si es Empleado: ");
        userType = char.Parse(Console.ReadLine());

    }
    
    User newUser;

    if (userType.Equals('c')) {

        Console.Write("\nRegimen Fiscal: "); 
        char taxRegime = char.Parse(Console.ReadLine());

        newUser = new Client (ID, name, email, balance, taxRegime);

    }



    else {

        Console.Write("\nDepartamento: "); 
        string department =  Console.ReadLine(); 
        newUser = new Employee (ID, name, email, balance, department);
    }

    Storage.AddUser(newUser);

    Console.WriteLine("\nUsuario Creado.");
    Thread.Sleep(2000);
    ShowMenu();


}

void DeleteUser() {

    Console.Clear();

    Console.Write("\nIngrese el ID del usuario a eliminar: ");
    int ID = int.Parse(Console.ReadLine());

    bool validID = false;

    while (!validID) {

        if ( ID < 0) {

            Console.WriteLine("\nEl ID debe ser un entero positivo.");
            Console.Write("\nIngrese el ID del usuario a eliminar: ");
            ID = int.Parse(Console.ReadLine());
        }

        else if (!Storage.GetNewUsers().Any(u  => u.GetID() == ID)) {

            Console.WriteLine("\nEl ID ingresado no existe.");
            Console.Write("\nIngrese el ID del usuario a eliminar: ");
            ID = int.Parse(Console.ReadLine());

        }

        else {

            validID = true;
        }

    }

    string result = Storage.DeleteUser(ID);

    if (result.Equals("Sucess")) {

        Console.WriteLine("\nUsuario Eliminado.");
        Thread.Sleep(2000);
        ShowMenu();

    }

}




/*

Mis disculpas por no ser más específico. Aquí te proporciono las instrucciones completas con el archivo y la línea correspondiente para cada modificación:

En el archivo Program.cs, debes modificar el método CreateUser() para agregar las validaciones al agregar usuarios. Debes agregar el siguiente código después de la línea int ID = int.Parse(Console.ReadLine());:
bool validID = false;
while (!validID)
{
    if (ID < 0)
    {
        Console.WriteLine("El ID debe ser un entero positivo.");
        Console.Write("\nID: ");
        ID = int.Parse(Console.ReadLine());
    }
    else if (Storage.GetUsers().Any(u => u.GetID() == ID))
    {
        Console.WriteLine("El ID ingresado ya existe.");
        Console.Write("\nID: ");
        ID = int.Parse(Console.ReadLine());
    }
    else
    {
        validID = true;
    }
}
Copiar
En el archivo Program.cs, debes modificar el método CreateUser() para agregar las validaciones al agregar usuarios. Debes agregar el siguiente código después de la línea string email = Console.ReadLine();:
bool validEmail = false;
while (!validEmail)
{
    try
    {
        var addr = new System.Net.Mail.MailAddress(email);
        validEmail = addr.Address == email;
    }
    catch
    {
        Console.WriteLine("El correo electrónico no es válido.");
        Console.Write("\nEmail: ");
        email = Console.ReadLine();
    }
}
Copiar
En el archivo Program.cs, debes modificar el método CreateUser() para agregar las validaciones al agregar usuarios. Debes agregar el siguiente código después de la línea decimal balance = decimal.Parse(Console.ReadLine());:
while (balance < 0)
{
    Console.WriteLine("El saldo debe ser un decimal positivo.");
    Console.Write("\nSaldo: ");
    balance = decimal.Parse(Console.ReadLine());
}
Copiar
En el archivo Program.cs, debes modificar el método CreateUser() para agregar las validaciones al agregar usuarios. Debes agregar el siguiente código después de la línea char userType = char.Parse(Console.ReadLine());:
while (userType != 'c' && userType != 'e')
{
    Console.WriteLine("Debes ingresar 'c' si el usuario es Cliente o 'e' si es Empleado.");
    Console.Write("\nEscribe 'c' si el usuario es Cliente, 'e' si es Empleado: ");
    userType = char.Parse(Console.ReadLine());
}
Copiar
En el archivo Program.cs, debes modificar el método DeleteUser() para agregar las validaciones al eliminar usuarios. Debes agregar el siguiente código después de la línea int ID = int.Parse(Console.ReadLine());:
bool validID = false;
while (!validID)
{
    if (ID < 0)
    {
        Console.WriteLine("El ID debe ser un entero positivo.");
        Console.Write("\nIngrese el ID del usuario a eliminar: ");
        ID = int.Parse(Console.ReadLine());
    }
    else if (!Storage.GetUsers().Any(u => u.GetID() == ID))
    {
        Console.WriteLine("El ID ingresado no existe.");
        Console.Write("\nIngrese el ID del usuario a eliminar: ");
        ID = int.Parse(Console.ReadLine());
    }
    else
    {
        validID = true;
    }
}
Copiar
En el archivo Storage.cs, debes agregar el método GetUsers() que te proporcioné anteriormente. Este método se utiliza para obtener una lista de todos los usuarios almacenados en el archivo JSON y es necesario para realizar las validaciones al agregar y eliminar usuarios.
public static List<User> GetUsers()
{
    string usersInFile = "";
    var listUsers = new List<User>();

    if (File.Exists(filePath))
    {
        usersInFile = File.ReadAllText(filePath);
    }

    var listObjects = JsonConvert.DeserializeObject<List<object>>(usersInFile);

    if (listObjects == null)
    {
        return listUsers;
    }

    foreach (object obj in listObjects)
    {
        User newUser;
        JObject user = (JObject)obj;

        if (user.ContainsKey("TaxRegime"))
        {
            newUser = user.ToObject<Client>();
        }
        else
        {
            newUser = user.ToObject<Employee>();
        }

        listUsers.Add(newUser);
    }

    return listUsers;
}


*/







