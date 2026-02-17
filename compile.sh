#!/bin/bash

# UKB RAP Tutorial 编译脚本
# 使用XeLaTeX编译LaTeX文档

echo "======================================"
echo "  UKB RAP教程 PDF编译脚本 v2.0"
echo "======================================"
echo ""

# 检查LaTeX是否安装
if ! command -v xelatex &> /dev/null; then
    echo "❌ 错误: 未找到xelatex命令"
    echo "请先安装MacTeX或TeX Live"
    exit 1
fi

echo "✓ 检测到XeLaTeX"
echo ""

# 文件名
TEXFILE="UKB_RAP_Tutorial.tex"

# 检查源文件是否存在
if [ ! -f "$TEXFILE" ]; then
    echo "错误: 找不到 $TEXFILE"
    exit 1
fi

echo "📝 开始编译..."
echo ""

# 第一次编译
echo "第一次编译 (生成辅助文件)..."
xelatex -interaction=nonstopmode "$TEXFILE" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 错误: 第一次编译失败"
    echo "请查看 UKB_RAP_Tutorial.log 文件获取详细错误信息"
    exit 1
fi

echo "✓ 第一次编译完成"

echo "第二次编译 (生成目录和交叉引用)..."
xelatex -interaction=nonstopmode "$TEXFILE" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 错误: 第二次编译失败"
    echo "请查看 UKB_RAP_Tutorial.log 文件获取详细错误信息"
    exit 1
fi

echo "✓ 第二次编译完成"
echo ""
echo "======================================"
echo "  ✅ 编译成功!"
echo "======================================"
echo ""
echo "📄 生成的PDF文件: UKB_RAP_Tutorial.pdf"
echo "📊 文件大小: $(ls -lh UKB_RAP_Tutorial.pdf | awk '{print $5}')"
echo ""

# 清理辅助文件 (可选)
read -p "是否清理辅助文件? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "清理辅助文件..."
    rm -f *.aux *.log *.out *.toc
    echo "清理完成!"
fi

echo ""
echo "您可以使用以下命令打开PDF:"
echo "open UKB_RAP_Tutorial.pdf"
