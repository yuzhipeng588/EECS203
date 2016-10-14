function Tdot = bldgHTM(T, u1, u2, q, mz, cz, cp)
Tdot=(q+cp*u1.*(u2-T))/(mz*cz);

end