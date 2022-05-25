Base.@kwdef struct PIDControllerParams
    kp = 0.0
    ki = 0.0
    kd = 0.0
end

function fd_pid_controller(t, controller, x_err=0.0, v_err=0.0)
    (; kp, ki, kd) = controller.p
    ∫x_err = controller.xd
    Δt = 1 / controller.sample_rate

    ∫x_err += x_err * Δt

    return (
        xd = ∫x_err,
        yd = kp*x_err + ki*∫x_err + kd*v_err,
    )
end

function PIDController(;
    name = "Controller",
    xd = 0.0,
    yd = 0.0,
    p = PIDControllerParams(),
    sample_rate = 10//1,
    kwargs...,
)
    return Model(;
        name = name,
        xd = xd,
        yd = yd,
        p = p,
        sample_rate = sample_rate,
        fd = fd_pid_controller,
        kwargs...,
    )
end