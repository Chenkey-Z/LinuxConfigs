#!/bin/bash

# 设置文件夹路径和重命名起始序号
folder_path="$HOME/视频/wallpapers"
start_index=0

# 检查文件夹是否存在
if [ ! -d "$folder_path" ]; then
  echo "文件夹不存在！"
  exit 1
fi

# 进入目标文件夹
cd "$folder_path" || exit 1

# 遍历文件夹内所有文件
for file in *; do
  # 如果是文件则进行重命名
  if [ -f "$file" ]; then
    # 获取文件扩展名
    extension="${file##*.}"
    # 构造新文件名
    new_name="${start_index}.${extension}"
    # 重命名文件
    mv "$file" "$new_name"
    # 更新序号
    ((start_index++))
  fi
done

echo "文件重命名完成！"

