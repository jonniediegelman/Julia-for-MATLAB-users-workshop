using LinearAlgebra
using Unitful: u, km, m, s, hr

import Base: +, -


## Point in 2D space
struct Point2D{L}
    x::L
    y::L
end
function Point2D(x::X, y::Y) where {X,Y}
    L = promote_type(X, Y)
    return Point2D(L(x), L(y))
end

+(p1::Point2D, p2::Point2D) = Point2D(p1.x + p2.x, p1.y + p2.y)

-(p::Point2D) = Point2D(-p.x, -p.y)
-(p1::Point2D, p2::Point2D) = p1 + -p2

LinearAlgebra.norm(p::Point2D) = sqrt(p.x^2 + p.y^2)


## Roads
abstract type Road end

struct DirtRoad{L} <: Road
    roughness::Float64
    waypoints::Vector{Point2D{L}}
end

struct ConcreteRoad{L} <: Road
    waypoints::Vector{Point2D{L}}
end

struct NoRoad{L} <: Road
    start_point::Point2D{L}
    stop_point::Point2D{L}
end


## Vehicles
abstract type Vehicle end
abstract type GroundVehicle end
abstract type AirVehicle end

struct Car{V} <: GroundVehicle
    speed::V
end

struct Motorcycle{V} <: GroundVehicle
    speed::V
end

struct Plane{V} <: AirVehicle
    airspeed::V
end

struct Helicopter{V} <: AirVehicle
    airspeed::V
end


## Weather
abstract type Weather end

struct Rain <: Weather end
struct NoRain <: Weather end

## Functions
speed(vehicle::AirVehicle, road, weather) = vehicle.airspeed
speed(vehicle::GroundVehicle, road, weather) = vehicle.speed
speed(vehicle::GroundVehicle, road::NoRoad, weather) = 0
speed(vehicle::Car, road::DirtRoad, weather::Rain) = 0
speed(vehicle::GroundVehicle, road::DirtRoad, weather::NoRain) = (1 - road.roughness) * vehicle.speed

waypoints(road::Road) = road.waypoints
waypoints(no_road::NoRoad) = (no_road.start_point, no_road.stop_point)

ground_distance(point1, point2) = norm(point1 - point2)
ground_distance(no_road::NoRoad) = ground_distance(waypoints(no_road)...)
function ground_distance(road::Road)
    points = waypoints(road)
    total = zero(points[1].x)
    last_point = points[1]
    for point in points
        total += ground_distance(last_point, point)
        last_point = point
    end
    return total
end

function air_distance(road)
    points = waypoints(road)
    return ground_distance(points[1], points[end])
end

travel_time(vehicle::GroundVehicle, road, weather) = ground_distance(road) / speed(vehicle, road, weather)
travel_time(vehicle::Car, road::DirtRoad, weather) = ground_distance(road) * (1 - road.roughness) / speed(vehicle, road, weather)
travel_time(vehicle::Motorcycle, road::DirtRoad, weather) = ground_distance(road) * (1 - 0.5 * road.roughness) / speed(vehicle, road, weather)
travel_time(vehicle::AirVehicle, road, weather) = air_distance(road) / speed(vehicle, road, weather)


## Make vehicles
points = [Point2D(x, rand()*500m) for x in (0:0.01:10)km]
t = travel_time(
    Car(25m/s),
    # Plane(20),

    # DirtRoad(0.3, points),
    ConcreteRoad(points),

    # NoRain(),
    Rain(),
)
hr.(t)