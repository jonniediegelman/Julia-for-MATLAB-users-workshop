function fc_controlled_cart(t, system)
    (; cart, controller) = system.models

    cart_out = continuous_dynamics(t, cart, controller.yd)

    return (models = (cart = cart_out,),)
end

function fd_controlled_cart(t, system)
    (; cart, controller) = system.models
    ref = system.p(t)

    x_err = ref.position - cart.xc.position
    v_err = ref.velocity - cart.xc.velocity
    ctrl_out = discrete_dynamics(t, controller, x_err, v_err)

    return (
        models = (controller = ctrl_out,),
        yd = (
            ref = ref,
            err = CartState(position=x_err, velocity=v_err),
        ),
    )
end

function ControlledCart(;
    name = "ControlledCart",
    cart = Cart(),
    controller = PIDController(),
    ref = t -> CartState(),
)
    return Model(
        name = name,
        yd = (ref=CartState(), err=CartState(),),
        p = ref,
        fc = fc_controlled_cart,
        fd = fd_controlled_cart,
        models = (
            cart = cart,
            controller = controller,
        ),
    )
end