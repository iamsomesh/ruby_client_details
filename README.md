# Client Search Tool (ClientExplorer)
This command-line tool allows you to search through client data and perform various operations. It's built using Ruby 3.2.2 and utilizes RVM for Ruby version management.

## 1. Prerequisites
Before using this tool, ensure you have the following prerequisites:
- Ruby 3.2.2 installed on your system.
To install Ruby using RVM, you can follow the instructions [here](https://rvm.io/rvm/install).
- Run bundle install to install the dependencies.
    ```bash
    bundle
    ```

## 3. Running the Test Suite
You can run the test suite with following command.
```bash
rspec
```

## 2. Running the Script
You can run the script with various options to search for clients, list all client or list duplicates.

### List All Clients
To list all clients use the following command:

```bash
ruby app.rb list
```

### Search for Clients by Name
To search for clients by name, use the following command:

```bash
ruby app.rb search 'Emma'
ruby app.rb search 'Jo'
```

### List Clients with the Same Email
To list clients with the same email, use the following command:

```bash
ruby app.rb list_duplicates
```

### Using a JSON File
You can also provide a JSON file containing client data and perform the same operations as above. To do this, specify the --file_path option:

```bash
ruby app.rb search 'Johnson' --file_path path/to/valid/json/file
ruby app.rb search 'duplicate@example.com' --file_path path/to/valid/json/file --search_field email
ruby app.rb list_duplicates --file_path path/to/valid/json/file
```

### Search with User-Specified Field
If you want to search based on a specific field (e.g., email), you can specify the field name:

```bash
ruby app.rb search 'jane.smith@yahoo.com' --search_field email
```

## Note
- This script is using Thor Gem to build a Interactive CLI.
- Awesome Print is being used to format the output.

## Things can be covered in future
- Can integrate more business logic as required to interact with data
- We can specify the fields we want in return like if we just want name or email etc instead of all fields.
- The script can be customized to add support for various functions with some sort of Database to support Persisted Data & CRUD operations.
- The business logic can be served over http using APIs
- We can add pagination if there are lot of records.
- We can make use to cache & some Memoization techniques by modifying the application behaviour slightly.
