<h1 align="center">lua-ordered-dict</h1>

<div align="center">
	A table that remembers the order of key-value pair assignments
</div>

Motivation
--

Lua tables are great, but they don't remember the order of key-value pair assignments. This is a problem when you want to iterate over the table in the order that the key-value pairs were assigned. This library solves that problem.

Assignment and retrieval of key-value pairs is, amortized, O(log(n)), using a modified version of theeman05's red-black tree library.