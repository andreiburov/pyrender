#version 330 core

layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in int gl_PrimitiveIDIn;

in VS_OUT {
    vec4 position;
    vec3 frag_position;
#ifdef NORMAL_LOC
    vec3 frag_normal;
#endif
#ifdef HAS_NORMAL_TEX
#ifdef TANGENT_LOC
#ifdef NORMAL_LOC
    mat3 tbn;
#endif
#endif
#endif
#ifdef TEXCOORD_0_LOC
    vec2 uv_0;
#endif
#ifdef TEXCOORD_1_LOC
    vec2 uv_1;
#endif
#ifdef COLOR_0_LOC
    vec4 color_multiplier;
#endif
} gs_in[];

out int gl_PrimitiveID;

out GS_OUT {
    vec3 frag_position;
#ifdef NORMAL_LOC
    vec3 frag_normal;
#endif
#ifdef HAS_NORMAL_TEX
#ifdef TANGENT_LOC
#ifdef NORMAL_LOC
    mat3 tbn;
#endif
#endif
#endif
#ifdef TEXCOORD_0_LOC
    vec2 uv_0;
#endif
#ifdef TEXCOORD_1_LOC
    vec2 uv_1;
#endif
#ifdef COLOR_0_LOC
    vec4 color_multiplier;
#endif
#ifdef BARYCENTRIC_COORDINATES
    vec4 barycentric_coordinates;
#endif
} gs_out;


void GenerateVertex(int index)
{
    gl_PrimitiveID = gl_PrimitiveIDIn;
    gs_out.frag_position = gs_in[index].frag_position;
#ifdef NORMAL_LOC
    gs_out.frag_normal = gs_in[index].frag_normal;
#endif
#ifdef HAS_NORMAL_TEX
#ifdef TANGENT_LOC
#ifdef NORMAL_LOC
    gs_out.tbn = gs_in[index].tbn;
#endif
#endif
#endif
#ifdef TEXCOORD_0_LOC
    gs_out.uv_0 = gs_in[index].uv_0;
#endif
#ifdef TEXCOORD_1_LOC
    gs_out.uv_1 = gs_in[index].uv_1;
#endif
#ifdef COLOR_0_LOC
    gs_out.color_multiplier = gs_in[index].color_multiplier;
#endif
#ifdef BARYCENTRIC_COORDINATES
    gs_out.barycentric_coordinates = vec4(0., 0., 0., 1.);
    gs_out.barycentric_coordinates[index] = 1.0;
#endif
    gl_Position = gs_in[index].position;
    EmitVertex();
}

void main()
{
    GenerateVertex(0);
    GenerateVertex(1);
    GenerateVertex(2);
    EndPrimitive();
}
