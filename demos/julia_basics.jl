## Basic Types
# Numbers
1 + 2
1 + 2.0
1//3 + 5//12
(1//2 + 5im) * (2//3)im

# Strings
"Hello" * ", world"
"na "^11 * "hey Jude"
"1 + 1 = $(1 + 1)"

# Arrays
[1, 2, 3]
[1 2 3]
[
    1 2 3
    4 5 6
    7 8 9
]

A = rand(3,3)
b = rand(3)
A \ b

true_vector = ones(3)
true_vector'

matrix_vector = ones(3,1)

true_vector' * true_vector
matrix_vector' * matrix_vector
true_vector' * matrix_vector
matrix_vector' * true_vector

new_vector = true_vector
new_vector[3] = 100
true_vector

sub_vector = true_vector[1:2]
sub_vector[2] = 500
true_vector

view_vector = @view true_vector[1:2]
view_vector[2] = 42
true_vector

[1, 2.0, 3 + 0im]
mixed_vector = [1, "hello", cos]
typeof(mixed_vector)
true_vector[1] = "words"
mixed_vector[1] = "words"
mixed_vector

# Tuples
tup = (1, "goodbye", cos)
typeof(tup)
tup[3]
tup[3] = sin

(tup..., 1//2)

# NamedTuples
named_tup = (a="ayyyy", b=3.0001)
named_tup.b
dynamic_field_name = :a
named_tup[field_name]

(named_tup..., c=1+im)
(named_tup..., 1+im)

# Dictionaries
dict = Dict("some key"=>"some value", "some other key"=>5)
dict["some key"]
dict["some key"] = 20
dict["some key"]


## Loops and control flow
# Loops and conditionals
vars = ["bunch", "of", "words"]
for var in vars
    println(var)
end
for i in eachindex(vars)
    println(i)
end
for (i, var) in enumerate(vars)
    if isodd(i)
        println(i, " -> ", var)
    end
end

# Comprehensions
[var[1:2] for var in vars]
[var[1:2] for var in vars if contains(var, "o")]

[lcm(x, y) for x in 1:10, y in 1:10]

# Broadcasting
x = π ./ [1, 2, 3]
sin(x)
sin.(x)
sin.(x')
sin.(x * x')

lcm.(4, 1:10)
lcm.((1:5)', 1:10)

(1:5)' .+ (0:10)

x .= 0
x


## Functions
# Syntax
function my_mult(x, y)
    return x * y
end
my_mult(3, 2)
my_mult("two", " words")

my_add(x, y) = x + y
my_add.([1, 2, 3], [4, 5, 6])
my_add.([1, 2, 3], 4)
my_add.([1, 2, 3], [4, 5]')

anon_div = (x, y) -> x / y

# Defaults and keyword args
function print_stuff(w, x=0; y, z=0)
    println(w+x)
    println("y = $y")
    println("z = $z")
end
print_stuff(1, 2, y=4, z=-2)
print_stuff(2)
print_stuff(2; y=20)
print_stuff(4; z=1, y=2)

# Mutation
some_numbers = [1, 2, 3, 4, 5]
function set_to_one!(some_numbers)
    some_numbers .= 1
    return nothing
end
set_to_one!(some_numbers)
some_numbers

# Splat/slurp
function show_args(x, args...; y, kwargs...)
    println(x)
    for arg in args
        println(arg)
    end
    println("y = $y")
    for (key, val) in kwargs
        println(key, " = ", val)
    end
end
show_args(1, 2, 3; y=4, z=5, w=6)
args = (3, 4)
kwargs = (y=7, z=3)
show_args(args...; kwargs...)

# Multiple dispatch
whats_this(x::String) = println("\"$x\" is a word!")
whats_this(x::Number) = println("$x is a number!")
whats_this(x::Real) = println("$x is a real number!")
whats_this("hello")
whats_this(3)
whats_this(3 + im)