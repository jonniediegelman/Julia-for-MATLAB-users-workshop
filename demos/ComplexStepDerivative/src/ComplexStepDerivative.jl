module ComplexStepDerivative

using LinearAlgebra

function derivative(f, x; h=1e-200)
    return imag(f(x + im*h)) / h
end

LinearAlgebra.adjoint(f::Function) = x -> derivative(f, x)

export derivative

end # module
