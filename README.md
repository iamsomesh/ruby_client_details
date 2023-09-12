#### 1. Install Ruby 3.0.0

[Install RVM](https://rvm.io/rvm/install)

After installing go to project directory and install 3.0.0 ruby version
```
cd [your-path]/[project-name]
rvm install 3.0.0
```

#### 2. Run the script for Search through all clients and return those with names

Just example:
```
ruby app.rb search "Emma"
```

#### 3. Find out if there are any clients with the same email

Just example:
```
ruby app.rb find_duplicates "jane.smith@yahoo.com"
```

### 4.  if we wanted to accept any JSON file and find out the same above results

Just example:
```
ruby app.rb search "Emma" --filename clients.json
ruby app.rb find_duplicates "jane.smith@yahoo.com" --filename clients.json
```

### 4. Search with user specifies field

Just example:
```
ruby app.rb search email "jane.smith@yahoo.com"
```