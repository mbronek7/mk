def return_binding
  foo = 100
  binding
end
# Foo jest dostępne dzięki binding,
# nawet gdy jesteśmy poza obszarem metody,
# która to definiuje.
puts return_binding.class
puts return_binding.eval('foo')
# Bezpośrednie wywołanie spowoduje błąd.
# Foo nie jest bowiem zdefiniowane globalnie.
puts foo

