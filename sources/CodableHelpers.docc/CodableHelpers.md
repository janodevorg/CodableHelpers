# ``CodableHelpers``

Provides Codables for unusual JSON structures.

## Overview

A value that appears as a single object or an array.
```
[
    { "employees": "Alice" },
    { "employees": ["Alice", "Bob"] }
]
```

A Int64 provided as a string.
```
{ "id": "429346429438" }
```

A JSON integer provided as a string or integer.
```
[
    { "age": 43 },
    { "age": "43" }
]
```

## Topics

### Group

- ``CodableArrayOrObject``
- ``CodableInt64FromString``
- ``CodableIntOrString``
