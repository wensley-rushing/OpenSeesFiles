# @Author: Mengsen.Wang
# @Date: 2020-10-24 11:41:35

# 500 * 500 * 50 * 50 * 50 * 50
# ---- 500
# |   | 500 (y)
# ---- 500
section Fiber 1 -GJ 1 {
  # 侧板
  fiber 0.225 0.025 2.5e-3 1
  fiber 0.225 0.075 2.5e-3 1
  fiber 0.225 0.125 2.5e-3 1
  fiber 0.225 0.175 2.5e-3 1

  fiber 0.225 -0.025 2.5e-3 1
  fiber 0.225 -0.075 2.5e-3 1
  fiber 0.225 -0.125 2.5e-3 1
  fiber 0.225 -0.175 2.5e-3 1

  fiber -0.225 0.025 2.5e-3 1
  fiber -0.225 0.075 2.5e-3 1
  fiber -0.225 0.125 2.5e-3 1
  fiber -0.225 0.175 2.5e-3 1

  fiber -0.225 -0.025 2.5e-3 1
  fiber -0.225 -0.075 2.5e-3 1
  fiber -0.225 -0.125 2.5e-3 1
  fiber -0.225 -0.175 2.5e-3 1

  # 顶板
  fiber 0.025 0.225 2.5e-3 1
  fiber 0.075 0.225 2.5e-3 1
  fiber 0.125 0.225 2.5e-3 1
  fiber 0.175 0.225 2.5e-3 1
  fiber 0.225 0.225 2.5e-3 1

  fiber -0.025 0.225 2.5e-3 1
  fiber -0.075 0.225 2.5e-3 1
  fiber -0.125 0.225 2.5e-3 1
  fiber -0.175 0.225 2.5e-3 1
  fiber -0.225 0.225 2.5e-3 1

  fiber 0.025 -0.225 2.5e-3 1
  fiber 0.075 -0.225 2.5e-3 1
  fiber 0.125 -0.225 2.5e-3 1
  fiber 0.175 -0.225 2.5e-3 1
  fiber 0.225 -0.225 2.5e-3 1

  fiber -0.025 -0.225 2.5e-3 1
  fiber -0.075 -0.225 2.5e-3 1
  fiber -0.125 -0.225 2.5e-3 1
  fiber -0.175 -0.225 2.5e-3 1
  fiber -0.225 -0.225 2.5e-3 1
}

# 500 * 800 * 30 * 30 * 30 *30
# ---- 800
# |   | 500 (y)
# ---- 800
section Fiber 2 -GJ 1 {
  # 侧板
  fiber 0.385 0.015 9e-4 1
  fiber 0.385 0.045 9e-4 1
  fiber 0.385 0.075 9e-4 1
  fiber 0.385 0.105 9e-4 1
  fiber 0.385 0.135 9e-4 1
  fiber 0.385 0.165 9e-4 1
  fiber 0.385 0.195 9e-4 1
  fiber 0.385 0.22 6e-4 1
  fiber 0.385 0.235 3e-4 1

  fiber -0.385 0.015 9e-4 1
  fiber -0.385 0.045 9e-4 1
  fiber -0.385 0.075 9e-4 1
  fiber -0.385 0.105 9e-4 1
  fiber -0.385 0.135 9e-4 1
  fiber -0.385 0.165 9e-4 1
  fiber -0.385 0.195 9e-4 1
  fiber -0.385 0.22 6e-4 1
  fiber -0.385 0.235 3e-4 1

  # 顶板
  fiber 0.385 0.015 9e-4 1
  fiber 0.385 0.045 9e-4 1
  fiber 0.385 0.105 9e-4 1
  fiber 0.385 0.135 9e-4 1
  fiber 0.385 0.165 9e-4 1
  fiber 0.385 0.195 9e-4 1
  fiber 0.385 0.225 9e-4 1
  fiber 0.385 0.255 9e-4 1
  fiber 0.385 0.285 9e-4 1
  fiber 0.385 0.315 9e-4 1
  fiber 0.385 0.345 9e-4 1
  fiber 0.385 0.375 9e-4 1

  fiber -0.385 0.015 9e-4 1
  fiber -0.385 0.045 9e-4 1
  fiber -0.385 0.105 9e-4 1
  fiber -0.385 0.135 9e-4 1
  fiber -0.385 0.165 9e-4 1
  fiber -0.385 0.195 9e-4 1
  fiber -0.385 0.225 9e-4 1
  fiber -0.385 0.255 9e-4 1
  fiber -0.385 0.285 9e-4 1
  fiber -0.385 0.315 9e-4 1
  fiber -0.385 0.345 9e-4 1
  fiber -0.385 0.375 9e-4 1

  fiber 0.385 -0.015 9e-4 1
  fiber 0.385 -0.045 9e-4 1
  fiber 0.385 -0.105 9e-4 1
  fiber 0.385 -0.135 9e-4 1
  fiber 0.385 -0.165 9e-4 1
  fiber 0.385 -0.195 9e-4 1
  fiber 0.385 -0.225 9e-4 1
  fiber 0.385 -0.255 9e-4 1
  fiber 0.385 -0.285 9e-4 1
  fiber 0.385 -0.315 9e-4 1
  fiber 0.385 -0.345 9e-4 1
  fiber 0.385 -0.375 9e-4 1

  fiber -0.385 -0.015 9e-4 1
  fiber -0.385 -0.045 9e-4 1
  fiber -0.385 -0.105 9e-4 1
  fiber -0.385 -0.135 9e-4 1
  fiber -0.385 -0.165 9e-4 1
  fiber -0.385 -0.195 9e-4 1
  fiber -0.385 -0.225 9e-4 1
  fiber -0.385 -0.255 9e-4 1
  fiber -0.385 -0.285 9e-4 1
  fiber -0.385 -0.315 9e-4 1
  fiber -0.385 -0.345 9e-4 1
  fiber -0.385 -0.375 9e-4 1
}

# 500 * 600 * 30 * 30 * 30 * 30
# ---- 600
# |   | 500 (y)
# ---- 600
section Fiber 3 -GJ 1 {
  # 侧板
  fiber 0.585 0.015 9e-4 1
  fiber 0.585 0.045 9e-4 1
  fiber 0.585 0.075 9e-4 1
  fiber 0.585 0.0105 9e-4 1
  fiber 0.585 0.0135 9e-4 1
  fiber 0.585 0.0165 9e-4 1
  fiber 0.585 0.0195 9e-4 1
  fiber 0.585 0.0215 3e-4 1

  fiber -0.585 0.015 9e-4 1
  fiber -0.585 0.045 9e-4 1
  fiber -0.585 0.075 9e-4 1
  fiber -0.585 0.0105 9e-4 1
  fiber -0.585 0.0135 9e-4 1
  fiber -0.585 0.0165 9e-4 1
  fiber -0.585 0.0195 9e-4 1
  fiber -0.585 0.0215 3e-4 1

  # 顶板
  fiber 0.015 0.235 9e-4 1
  fiber 0.045 0.235 9e-4 1
  fiber 0.075 0.235 9e-4 1
  fiber 0.0105 0.235 9e-4 1
  fiber 0.0135 0.235 9e-4 1
  fiber 0.0165 0.235 9e-4 1
  fiber 0.0195 0.235 9e-4 1
  fiber 0.0225 0.235 9e-4 1
  fiber 0.0255 0.235 9e-4 1
  fiber 0.0285 0.235 9e-4 1

  fiber 0.015 -0.235 9e-4 1
  fiber 0.045 -0.235 9e-4 1
  fiber 0.075 -0.235 9e-4 1
  fiber 0.0105 -0.235 9e-4 1
  fiber 0.0135 -0.235 9e-4 1
  fiber 0.0165 -0.235 9e-4 1
  fiber 0.0195 -0.235 9e-4 1
  fiber 0.0225 -0.235 9e-4 1
  fiber 0.0255 -0.235 9e-4 1
  fiber 0.0285 -0.235 9e-4 1

  fiber -0.015 0.235 9e-4 1
  fiber -0.045 0.235 9e-4 1
  fiber -0.075 0.235 9e-4 1
  fiber -0.0105 0.235 9e-4 1
  fiber -0.0135 0.235 9e-4 1
  fiber -0.0165 0.235 9e-4 1
  fiber -0.0195 0.235 9e-4 1
  fiber -0.0225 0.235 9e-4 1
  fiber -0.0255 0.235 9e-4 1
  fiber -0.0285 0.235 9e-4 1

  fiber -0.015 -0.235 9e-4 1
  fiber -0.045 -0.235 9e-4 1
  fiber -0.075 -0.235 9e-4 1
  fiber -0.0105 -0.235 9e-4 1
  fiber -0.0135 -0.235 9e-4 1
  fiber -0.0165 -0.235 9e-4 1
  fiber -0.0195 -0.235 9e-4 1
  fiber -0.0225 -0.235 9e-4 1
  fiber -0.0255 -0.235 9e-4 1
  fiber -0.0285 -0.235 9e-4 1
}

# 200 * 200 * 20 * 20 * 20 * 20
# ---- 200
# |   | 200 (y)
# ---- 200
section Fiber 4 -GJ 1 {
  # 侧板
  fiber 0.09 0.01 2e-4 1
  fiber 0.09 0.03 2e-4 1
  fiber 0.09 0.05 2e-4 1
  fiber 0.09 0.07 2e-4 1

  fiber -0.09 0.01 2e-4 1
  fiber -0.09 0.03 2e-4 1
  fiber -0.09 0.05 2e-4 1
  fiber -0.09 0.07 2e-4 1

  # 顶板
  fiber 0.09 0.01 2e-4 1
  fiber 0.09 0.03 2e-4 1
  fiber 0.09 0.05 2e-4 1
  fiber 0.09 0.07 2e-4 1
  fiber 0.09 0.09 2e-4 1

  fiber 0.09 -0.01 2e-4 1
  fiber 0.09 -0.03 2e-4 1
  fiber 0.09 -0.05 2e-4 1
  fiber 0.09 -0.07 2e-4 1
  fiber 0.09 -0.09 2e-4 1

  fiber -0.09 0.01 2e-4 1
  fiber -0.09 0.03 2e-4 1
  fiber -0.09 0.05 2e-4 1
  fiber -0.09 0.07 2e-4 1
  fiber -0.09 0.09 2e-4 1

  fiber -0.09 -0.01 2e-4 1
  fiber -0.09 -0.03 2e-4 1
  fiber -0.09 -0.05 2e-4 1
  fiber -0.09 -0.07 2e-4 1
  fiber -0.09 -0.09 2e-4 1
}

# H14 * 350 * 200 * 16 * 200 * 16
# 200 |   |
#     |---| 350 (y)
#     |   | 200
section Fiber 5 -GJ 1 {
  # 腹板
  fiber 0.0 0.0 1.96e-4 1
  fiber 0.014 0.0 1.96e-4 1
  fiber 0.028 0.0 1.96e-4 1
  fiber 0.042 0.0 1.96e-4 1
  fiber 0.056 0.0 1.96e-4 1
  fiber 0.07 0.0 1.96e-4 1
  fiber 0.084 0.0 1.96e-4 1
  fiber 0.098 0.0 1.96e-4 1
  fiber 0.112 0.0 1.96e-4 1
  fiber 0.126 0.0 1.96e-4 1
  fiber 0.14 0.0 1.96e-4 1
  fiber 0.154 0.0 1.96e-4 1
  fiber 0.168 0.0 1.96e-4 1

  fiber -0.014 0.0 1.96e-4 1
  fiber -0.028 0.0 1.96e-4 1
  fiber -0.042 0.0 1.96e-4 1
  fiber -0.056 0.0 1.96e-4 1
  fiber -0.07 0.0 1.96e-4 1
  fiber -0.084 0.0 1.96e-4 1
  fiber -0.098 0.0 1.96e-4 1
  fiber -0.112 0.0 1.96e-4 1
  fiber -0.126 0.0 1.96e-4 1
  fiber -0.14 0.0 1.96e-4 1
  fiber -0.154 0.0 1.96e-4 1
  fiber -0.168 0.0 1.96e-4 1

  # 翼缘
  fiber 0.168 0.015 2.56e-4 1
  fiber 0.168 0.031 2.56e-4 1
  fiber 0.168 0.047 2.56e-4 1
  fiber 0.168 0.063 2.56e-4 1
  fiber 0.168 0.079 2.56e-4 1
  fiber 0.168 0.0935 2.08e-4 1

  fiber 0.168 -0.015 2.56e-4 1
  fiber 0.168 -0.031 2.56e-4 1
  fiber 0.168 -0.047 2.56e-4 1
  fiber 0.168 -0.063 2.56e-4 1
  fiber 0.168 -0.079 2.56e-4 1
  fiber 0.168 -0.0935 2.08e-4 1

  fiber -0.168 0.015 2.56e-4 1
  fiber -0.168 0.031 2.56e-4 1
  fiber -0.168 0.047 2.56e-4 1
  fiber -0.168 0.063 2.56e-4 1
  fiber -0.168 0.079 2.56e-4 1
  fiber -0.168 0.0935 2.08e-4 1

  fiber -0.168 -0.015 2.56e-4 1
  fiber -0.168 -0.031 2.56e-4 1
  fiber -0.168 -0.047 2.56e-4 1
  fiber -0.168 -0.063 2.56e-4 1
  fiber -0.168 -0.079 2.56e-4 1
  fiber -0.168 -0.0935 2.08e-4 1
}

# H16 * 450 * 200 * 16 * 200 * 16
# 200 |   |
#     |---| 450 (y)
#     |   | 200
section Fiber 6 -GJ 1 {
  # 腹板
  fiber 8e-3 0 2.56e-4 1
  fiber 0.024 0 2.56e-4 1
  fiber 0.04 0 2.56e-4 1
  fiber 0.056 0 2.56e-4 1
  fiber 0.072 0 2.56e-4 1
  fiber 0.088 0 2.56e-4 1
  fiber 0.104 0 2.56e-4 1
  fiber 0.12 0 2.56e-4 1
  fiber 0.136 0 2.56e-4 1
  fiber 0.152 0 2.56e-4 1
  fiber 0.168 0 2.56e-4 1
  fiber 0.184 0 2.56e-4 1
  fiber 0.2 0 2.56e-4 1
  fiber 0.216 0 2.72e-4 1

  fiber -8e-3 0 2.56e-4 1
  fiber -0.024 0 2.56e-4 1
  fiber -0.04 0 2.56e-4 1
  fiber -0.056 0 2.56e-4 1
  fiber -0.072 0 2.56e-4 1
  fiber -0.088 0 2.56e-4 1
  fiber -0.104 0 2.56e-4 1
  fiber -0.12 0 2.56e-4 1
  fiber -0.136 0 2.56e-4 1
  fiber -0.152 0 2.56e-4 1
  fiber -0.168 0 2.56e-4 1
  fiber -0.184 0 2.56e-4 1
  fiber -0.2 0 2.56e-4 1
  fiber -0.216 0 2.72e-4 1

  # 翼缘
  fiber 0.216 0.016 2.56e-4 1
  fiber 0.216 0.032 2.56e-4 1
  fiber 0.216 0.048 2.56e-4 1
  fiber 0.216 0.064 2.56e-4 1
  fiber 0.216 0.08 2.56e-4 1
  fiber 0.216 0.94 1.92e-4 1

  fiber 0.216 -0.016 2.56e-4 1
  fiber 0.216 -0.032 2.56e-4 1
  fiber 0.216 -0.048 2.56e-4 1
  fiber 0.216 -0.064 2.56e-4 1
  fiber 0.216 -0.08 2.56e-4 1
  fiber 0.216 -0.94 1.92e-4 1

  fiber -0.216 0.016 2.56e-4 1
  fiber -0.216 0.032 2.56e-4 1
  fiber -0.216 0.048 2.56e-4 1
  fiber -0.216 0.064 2.56e-4 1
  fiber -0.216 0.08 2.56e-4 1
  fiber -0.216 0.94 1.92e-4 1

  fiber -0.216 -0.016 2.56e-4 1
  fiber -0.216 -0.032 2.56e-4 1
  fiber -0.216 -0.048 2.56e-4 1
  fiber -0.216 -0.064 2.56e-4 1
  fiber -0.216 -0.08 2.56e-4 1
  fiber -0.216 -0.94 1.92e-4 1
}