using Test
using CartControl

# Model params
init_state = CartState(velocity = 1.0)
cart = Cart(xc_0 = init_state)

# Sim params
t_end = 10//1
dt_max = 1//10

@testset "SimpleCart" begin
    out = simulate!(cart; t_end=t_end, dt_max=dt_max)
    
    expected_pos = init_state.velocity * t_end
    @test out[cart].xc[end].position ≈ expected_pos
end
