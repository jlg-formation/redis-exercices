# Jedis example

Jedis is a Java REDIS Client.

- Build Tool: Gradle
- IDE: VSCode

```
mkdir 01-jedis
cd 01-jedis
gradle init
// application, java, default...
```

Add into `.gitignore`:

```
.vscode
.idea
app/bin
```

VScode extension:

```
Extension Pack for Java
Gradle for Java
```

When updating the `build.gradle` file, do not forget to run the command palette `Java: Clean Java Language Server Workspace`.

Run a redis on `localhost:6379` with docker.

```
docker run -p 6379:6379 --name my-redis -d redis
```

Test the code.

To remove the SL4J warning, add in the `build.gradle`

```
implementation 'org.slf4j:slf4j-simple:2.0.7'
```

# Special command
