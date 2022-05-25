1 + 2.0
## 
x = 1
y = 5
z = x + y

##
1//3
1//3 + 5//12

"na "^11 * "hey jude"
"1 + 1 = $(x)"

[1, 2, 3]
[
    1 2 3
    4 5 6
]
[1 2 3; 4 5 6]

true_vector = ones(3)
true_vector'

matrix_vector = ones(3,1)

true_vector' * matrix_vector
true_vector' * true_vector
true_vector' * matrix_vector
matrix_vector' * matrix_vector

new_vector = true_vector
new_vector[3] = 100

sub_vector = true_vector[1:2]
sub_vector[2] = 500
sub_vector

view_vect = @view true_vector[1:2]
view_vect[2] = 42

[1, 2.0, 1+im]
x = [1, "hello", cos]
x[3]

tup = (1, "goodbye", cos)
tup[1] = 4

(tup..., 1//2)

named_tup = (a="ayyyy", b=3.001)
named_tup.a
named_tup.a = 0
fname = :a
named_tup[fname]

(named_tup..., c=3)

dict = Dict("some key"=>3, "some other key"=>4)
dict["some key"] = 5


vars = ["bunch", "of", "words"]
for (i, var) in enumerate(vars)
    println(i, "->", var)
end
mat = rand(3,3)
for elem in mat
    println(elem)
end

[var[1:2] for var in vars if contains(var, "o")]

[lcm(x, y) for x in 1:10, y in 1:5]

x = π ./ [1, 2, 3]
sin(x)
sin.(x)
sin.(x')
sin.(x * x')

lcm.((1:5)', 1:10)
x + x

x .= 0

1:1000000000000000000

function my_mult(x, y)
    x = copy(x)
    x .= 0
    return x+y
end
my_mult([1], 4)

f(x) = x+5
f(4)

g = (x, y) -> x - y

function do_stuff(x, y=0; z, w=3)
    return x + y * (z + w)
end

function whats_this(x::String)
    return println("$x is a word!")
end
whats_this(x::Number) = println("$x is a number!")
whats_this(x::Matrix{Complex}) = println("$x is real!")
