using ComplexStepDerivative
using Test

x = rand()

@testset "Built-in functions" begin
    @test sin'(x) ≈ derivative(sin, x) ≈ cos(x)
    @test exp'(x) ≈ exp(x)
end

@testset "Derivative rules" begin
    product_rule(f1, f2, x) = f1'(x) * f2(x) + f1(x) * f2'(x)
    chain_rule(f1, f2, x) = f1'(f2(x)) * f2'(x)

    f(x) = (sin(x) * exp(2x))^2
    g(x) = (1 + x) / x
    fxg = x -> f(x) * g(x)
    
    @test fxg'(x) ≈ product_rule(f, g, x)
    @test (f∘g)'(x) ≈ chain_rule(f, g, x)
end