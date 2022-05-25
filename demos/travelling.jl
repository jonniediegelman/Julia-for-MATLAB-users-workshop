using LinearAlgebra

struct Point2D
    x::Float64
    y::Float64
end

import Base: +, -

+(p1::Point2D, p2::Point2D) = Point2D(p1.x+p2.x, p1.y+p2.y)
-(p::Point2D) = Point2D(-p.x, -p.y)
-(p1::Point2D, p2::Point2D) = p1 + -p2

LinearAlgebra.norm(p::Point2D) = sqrt(p.x^2 + p.y^2)

