@register Base.getindex(x,i::Integer) false
@register Base.getindex(x,i) false
@register Base.binomial(n,k)

@register Base.signbit(x)
derivative(::typeof(signbit), args::NTuple{1,Any}, ::Val{1}) = 0
derivative(::typeof(abs), args::NTuple{1,Any}, ::Val{1}) = IfElse.ifelse(signbit(args[1]),-one(args[1]),one(args[1]))
function derivative(::typeof(min), args::NTuple{2,Any}, ::Val{1})
    x, y = args
    IfElse.ifelse(x < y, one(x), zero(x))
end
function derivative(::typeof(min), args::NTuple{2,Any}, ::Val{2})
    x, y = args
    IfElse.ifelse(x < y, zero(y), one(y))
end
function derivative(::typeof(max), args::NTuple{2,Any}, ::Val{1})
    x, y = args
    IfElse.ifelse(x > y, one(x), zero(x))
end
function derivative(::typeof(max), args::NTuple{2,Any}, ::Val{2})
    x, y = args
    IfElse.ifelse(x > y, zero(y), one(y))
end

IfElse.ifelse(x::Num,y,z) = Num(Term{Real}(IfElse.ifelse, [value(x), value(y), value(z)]))
derivative(::typeof(IfElse.ifelse), args::NTuple{3,Any}, ::Val{1}) = 0
derivative(::typeof(IfElse.ifelse), args::NTuple{3,Any}, ::Val{2}) = IfElse.ifelse(args[1],1,0)
derivative(::typeof(IfElse.ifelse), args::NTuple{3,Any}, ::Val{3}) = IfElse.ifelse(args[1],0,1)

@register Base.rand(x)
@register Base.randn(x)

@register Distributions.pdf(dist,x)
@register Distributions.logpdf(dist,x)
@register Distributions.cdf(dist,x)
@register Distributions.logcdf(dist,x)
@register Distributions.quantile(dist,x)

@register Distributions.Uniform(mu,sigma) false
@register Distributions.Normal(mu,sigma) false

@register ∈(x::Num, y::AbstractArray)
@register ∪(x, y)
@register ∩(x, y)

function ∨ end
function ∧ end
function ⊆ end

@register ∨(x, y)
@register ∧(x, y)
@register ⊆(x, y)
