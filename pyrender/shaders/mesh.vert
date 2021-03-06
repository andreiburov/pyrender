#version 430 core

// Vertex Attributes
layout(location = 0) in vec3 position;
#ifdef NORMAL_LOC
layout(location = NORMAL_LOC) in vec3 normal;
#endif
#ifdef TANGENT_LOC
layout(location = TANGENT_LOC) in vec4 tangent;
#endif
#ifdef TEXCOORD_0_LOC
layout(location = TEXCOORD_0_LOC) in vec2 texcoord_0;
#endif
#ifdef TEXCOORD_1_LOC
layout(location = TEXCOORD_1_LOC) in vec2 texcoord_1;
#endif
#ifdef COLOR_0_LOC
layout(location = COLOR_0_LOC) in vec4 color_0;
#endif
#ifdef JOINTS_0_LOC
layout(location = JOINTS_0_LOC) in vec4 joints_0;
#endif
#ifdef WEIGHTS_0_LOC
layout(location = WEIGHTS_0_LOC) in vec4 weights_0;
#endif
layout(location = INST_M_LOC) in mat4 inst_m;

in int gl_VertexID;

// Uniforms
uniform mat4 M;
uniform mat4 V;
uniform mat4 P;

// Outputs
out VS_OUT {
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
     int id;
} vs_out;


void main()
{
     vs_out.position = P * V * M * inst_m * vec4(position, 1);
     gl_Position = P * V * M * inst_m * vec4(position, 1);
     vs_out.frag_position = vec3(M * inst_m * vec4(position, 1.0));
 
     mat4 N = transpose(inverse(M * inst_m));

#ifdef NORMAL_LOC
     vs_out.frag_normal = normalize(vec3(N * vec4(normal, 0.0)));
#endif

#ifdef HAS_NORMAL_TEX
#ifdef TANGENT_LOC
#ifdef NORMAL_LOC
     vec3 normal_w = normalize(vec3(N * vec4(normal, 0.0)));
     vec3 tangent_w = normalize(vec3(N * vec4(tangent.xyz, 0.0)));
     vec3 bitangent_w = cross(normal_w, tangent_w) * tangent.w;
     vs_out.tbn = mat3(tangent_w, bitangent_w, normal_w);
#endif
#endif
#endif
#ifdef TEXCOORD_0_LOC
     vs_out.uv_0 = texcoord_0;
#endif
#ifdef TEXCOORD_1_LOC
     vs_out.uv_1 = texcoord_1;
#endif
#ifdef COLOR_0_LOC
     vs_out.color_multiplier = color_0;
#endif

     vs_out.id = gl_VertexID;
}
