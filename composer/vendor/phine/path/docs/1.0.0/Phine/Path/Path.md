<small>Phine\Path</small>

Path
====

Provides utility methods for file system paths.

Signature
---------

- It is a(n) **class**.

Methods
-------

The class defines the following methods:

- [`canonical()`](#canonical) &mdash; Canonicalizes the file system path.
- [`current()`](#current) &mdash; Returns the current working directory path.
- [`isAbsolute()`](#isAbsolute) &mdash; Checks if a file system path is absolute.
- [`isLocal()`](#isLocal) &mdash; Checks if a path is a local file system path.
- [`join()`](#join) &mdash; Joins a split file system path.
- [`remove()`](#remove) &mdash; Recursively removes a file system path.
- [`split()`](#split) &mdash; Splits the file system path.

### `canonical()` <a name="canonical"></a>

Canonicalizes the file system path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`string`) &mdash; The path to canoncalize.
- _Returns:_ The canoncalized path.
    - `string`

### `current()` <a name="current"></a>

Returns the current working directory path.

#### Description

The `getcwd()` function may return `false` if the parent of the current
working directory is not readable. To workaround this issue, this method
will check environment variables that may be set by the operating system
for the current path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$env` (`boolean`) &mdash; Only use the environment variables?
- _Returns:_ The current working directory path.
    - `string`
- It throws one of the following exceptions:
    - [`Exception`](http://php.net/class.Exception)
    - `PathException` &mdash; If the path could not be found.

### `isAbsolute()` <a name="isAbsolute"></a>

Checks if a file system path is absolute.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`string`) &mdash; The path to check.
- _Returns:_ Returns `true` if absolute, `false` if not.
    - `boolean`

### `isLocal()` <a name="isLocal"></a>

Checks if a path is a local file system path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`string`) &mdash; The path to check.
- _Returns:_ Returns `true` if local, `false` if not.
    - `boolean`

### `join()` <a name="join"></a>

Joins a split file system path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`array`) &mdash; The split path.
- _Returns:_ The joined path.
    - `string`

### `remove()` <a name="remove"></a>

Recursively removes a file system path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`string`) &mdash; The path to remove.
- _Returns:_ The number of paths removed.
    - `integer`
- It throws one of the following exceptions:
    - [`Exception`](http://php.net/class.Exception)
    - `PathException` &mdash; If the path could not be removed.

### `split()` <a name="split"></a>

Splits the file system path.

#### Signature

- It is a **public static** method.
- It accepts the following parameter(s):
    - `$path` (`string`) &mdash; The path to split.
- _Returns:_ The split path.
    - `array`

