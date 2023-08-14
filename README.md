<h1 align="center">lua-ordered-dict</h1>

<div align="center">
	A table that remembers the order of key-value pair assignments
</div>

Motivation
--

Lua tables are great, but they don't remember the order of key-value pair assignments. This is a problem when you want to iterate over the table in the order that the key-value pairs were assigned. 

```
local dict = {
    a = 1,
    b = 2,
    c = 3,
    d = 4
}

for k, v in pairs(dict) do
    print(k, v) -- in order: a 1, d 4, c 3, b 2
end
```


This library solves that problem.

Assignment and retrieval of key-value pairs is, amortized, O(log(n)), using a modified version of theeman05's red-black tree library.

Example:
```
local dict = require(path.to.dict)

local mydict = dict:init(
    {'a', 1}, 
    {'b', 2}, 
    {'c', 3}, 
    {'d', 4}
)

mydict.set('e', 5)
print(mydict.get('d')) -- 4
for k, v in mydict:pairs() do
    print(k, v) -- in order: a 1, b 2, c 3, d 4, e 5
end
```