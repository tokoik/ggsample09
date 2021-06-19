#version 410 core

// 光源
const vec4 pl = vec4(3.0, 4.0, 5.0, 1.0);           // 位置

// 頂点属性
in vec4 pv;                                         // ローカル座標系の頂点位置
in vec4 nv;                                         // 頂点の法線ベクトル
in vec2 tv;                                         // 頂点のテクスチャ座標

// 変換行列
uniform mat4 mw;                                    // 視点座標系への変換行列
uniform mat4 mc;                                    // クリッピング座標系への変換行列
uniform mat4 mg;                                    // 法線ベクトルの変換行列

// ラスタライザに送る頂点属性
out vec3 l;                                         // 光線ベクトル
out vec3 h;                                         // 中間ベクトル
out vec2 tc;                                        // テクスチャ座標

void main(void)
{
  vec3 n = normalize((mg * nv).xyz);                // 法線ベクトル
  vec3 t = normalize(vec3(n.z, 0.0, -n.x));         // 接線ベクトル
  vec3 b = cross(n, t);                             // 従接線ベクトル
  mat3 m = transpose(mat3(t, b, n));                // 接空間基底行列

  vec4 p = mw * pv;                                 // 視点座標系の頂点の位置
  vec3 v = -m * normalize(p.xyz / p.w);             // 頂点の接空間における視線ベクトル

  l = normalize(m * vec3(4.0, 5.0, 6.0));           // 頂点の接空間における光線ベクトル
  h = normalize(l + v);                             // 頂点の接空間における中間ベクトル
  tc = tv;                                          // テクスチャ座標

  gl_Position = mc * pv;
}
