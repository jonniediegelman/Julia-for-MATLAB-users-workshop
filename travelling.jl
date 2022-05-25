using LinearAlgebra

import Base: +, -


## Point in 2D space
struct Point2D
    x::Float64
    y::Float64
end

+(p1::Point2D, p2::Point2D) = Point2D(p1.x + p2.x, p1.y + p2.y)

-(p::Point2D) = Point2D(-p.x, -p.y)
-(p1::Point2D, p2::Point2D) = p1 + -p2

LinearAlgebra.norm(p::Point2D) = sqrt(p.x^2 + p.y^2)


## Roads
abstract type Road end

struct DirtRoad <: Road
    roughness::Float64
    waypoints::Vector{Point2D}
end

struct ConcreteRoad <: Road
    waypoints::Vector{Point2D}
end

struct NoRoad <: Road
    start_point::Point2D
    stop_point::Point2D
end


## Vehicles
abstract type Vehicle end
abstract type GroundVehicle end
abstract type AirVehicle end

struct Car <: GroundVehicle
    speed::Float64
end

struct Motorcycle <: GroundVehicle
    speed::Float64
end

struct Plane <: AirVehicle
    airspeed::Float64
end

struct Helicopter <: AirVehicle
    airspeed::Float64
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
    total = 0.0
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
points = [Point2D(x, rand()*100) for x in 0:10_000]
travel_time(
    Car(25),
    # Plane(20),

    # DirtRoad(0.3, points),
    ConcreteRoad(points),

    # NoRain(),
    Rain(),
)