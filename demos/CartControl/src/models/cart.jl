Base.@kwdef struct CartParams
    mass::Float64 = 1500.0
    max_accel::Float64 = 10.0
end

Base.@kwdef struct CartState
    position::Float64 = 0.0
    velocity::Float64 = 0.0
end
@integrable CartState

function fc_cart(t, cart, F=0.0)
    v = cart.xc.velocity
    m, a_max = cart.p.mass, cart.p.max_accel

    a = clamp(F/m, -a_max, a_max)

    xc_dot = CartState(
        position = v,
        velocity = a,
    )

    return (xc_dot = xc_dot,)
end

function Cart(;
    name = "Cart",
    xc_0 = CartState(),
    p = CartParams(),
    kwargs...,
)
    return Model(
        name = name,
        p = p,
        xc = xc_0,
        fc = fc_cart,
        kwargs...,
    )
end