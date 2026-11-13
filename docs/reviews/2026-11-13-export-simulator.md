# 协议导出模拟器检查

- 范围：iOS 27.0 iPhone 18 Pro Max 模拟器，PDF 和 PNG 生成；协议列表点击入口。
- 修复：`sexual/查看协议/MineAgreementListVC.swift` 的集合视图选择回调名称错误，已改为 `didSelectItemAt`。
- 验证：使用临时测试入口在模拟器调用 `sexual/查看协议/AgreementExporter.swift`，测试数据包含 100 个编号段落和结尾标记。PDF 为 7 页 A4，文本提取确认 100 段按序存在，首尾页视觉检查通过；PNG 为 1190 × 9788，末尾段落及结束标记可见。
- 普通 Debug 版本重新构建并安装成功；临时测试入口已从源码移除。
- 局限：模拟器自动操作工具无法加载 Xcode 27 的 SimulatorKit，图形控制接口超时；未能从协议列表交互进入详情，也未操作系统分享面板、保存到文件或相册。未测试真机或 iOS 26。
