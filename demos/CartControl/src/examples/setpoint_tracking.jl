using CartControl

# Cart model
cart = Cart(
    p = CartParams(
        mass = 50.0,
        max_accel = 5.0,
    ),
    xc_0 = CartState(),
)

# Controller model
controller = PIDController(
    p = PIDControllerParams(
        kp = 10.0,
        # ki = 0.5,
        kd = 50.0,
    ),
)

# System model
setpoint = 100.0
ref_signal = t -> CartState(position=setpoint)
controlled_cart = ControlledCart(
    cart = cart,
    controller = controller,
    ref = ref_signal,
)

# Run the simulation
t_end = 100//1
dt_max = 1//10
out = simulate!(controlled_cart; t_end=t_end, dt_max=dt_max)
