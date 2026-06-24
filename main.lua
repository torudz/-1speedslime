-- =======================================================
-- SUPER PREMIUM PRO ULTRA: SEPARATED MODES + CUSTOM THREADS
-- =======================================================

if game.CoreGui:FindFirstChild("BadaoAutoFarmUI") then
    game.CoreGui.BadaoAutoFarmUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local StatusText = Instance.new("TextLabel")

-- Khởi tạo các nút bấm Auto tách biệt
local SpeedBtn = Instance.new("TextButton")
local WinBtn = Instance.new("TextButton")
local RebirthBtn = Instance.new("TextButton")
local AfkOpenBtn = Instance.new("TextButton")

-- Ô nhập số luồng
local ThreadLabel = Instance.new("TextLabel")
local ThreadInput = Instance.new("TextBox")

-- Khởi tạo ScreenGui
ScreenGui.Name = "BadaoAutoFarmUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true 

-- Giao diện Bảng chính (Nới rộng kích thước để vừa các nút mới)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22) 
MainFrame.Position = UDim2.new(0.5, -120, 0.3, -110)
MainFrame.Size = UDim2.new(0, 240, 0, 240)
MainFrame.Active = true
MainFrame.Draggable = true 

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(0, 170, 255) 
UIStroke.Thickness = 2

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 8)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.FredokaOne
Title.Text = "⚡ GOD MODE FARM VIP ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

StatusText.Name = "StatusText"
StatusText.Parent = MainFrame
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0, 0, 0, 30)
StatusText.Size = UDim2.new(1, 0, 0, 18)
StatusText.Font = Enum.Font.SourceSansItalic
StatusText.Text = "Hệ thống: Sẵn sàng"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 160)
StatusText.TextSize = 12

-- Hàm tạo nút bấm nhanh cho UI chính
local function createMenuButton(btn, text, color, yPos, height)
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.08, 0, 0, yPos)
    btn.Size = UDim2.new(0.84, 0, 0, height or 30)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
end

-- Tạo 3 nút Auto riêng biệt + Nút mở AFK
createMenuButton(SpeedBtn, "🔥 AUTO SPEED: OFF", Color3.fromRGB(230, 40, 70), 55, 32)
createMenuButton(WinBtn, "🏆 AUTO WIN: OFF", Color3.fromRGB(230, 40, 70), 92, 32)
createMenuButton(RebirthBtn, "🔄 AUTO REBIRTH: OFF", Color3.fromRGB(230, 40, 70), 129, 32)

-- Khu vực cấu hình Số Luồng (Threads)
ThreadLabel.Parent = MainFrame
ThreadLabel.BackgroundTransparency = 1
ThreadLabel.Position = UDim2.new(0.08, 0, 0, 170)
ThreadLabel.Size = UDim2.new(0.5, 0, 0, 25)
ThreadLabel.Font = Enum.Font.GothamBold
ThreadLabel.Text = "SỐ LUỒNG (THREADS):"
ThreadLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ThreadLabel.TextSize = 11
ThreadLabel.TextXAlignment = Enum.TextXAlignment.Left

ThreadInput.Parent = MainFrame
ThreadInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ThreadInput.Position = UDim2.new(0.65, 0, 0, 168)
ThreadInput.Size = UDim2.new(0.27, 0, 0, 26)
ThreadInput.Font = Enum.Font.Code
ThreadInput.Text = "1"
ThreadInput.TextColor3 = Color3.fromRGB(0, 255, 255)
ThreadInput.TextSize = 14
local inputCorner = Instance.new("UICorner", ThreadInput)
inputCorner.CornerRadius = UDim.new(0, 4)

createMenuButton(AfkOpenBtn, "🖥️ CHẾ ĐỘ MAN HÌNH ĐEN AFK", Color3.fromRGB(45, 45, 60), 202, 28)

-- =======================================================
-- MÀN HÌNH ĐEN AFK PHIÊN BẢN MONITOR HACKER TRÀN VIỀN
-- =======================================================
local AfkFrame = Instance.new("TextButton")
AfkFrame.Name = "AfkFrame"
AfkFrame.Parent = ScreenGui
AfkFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
AfkFrame.Size = UDim2.new(1.5, 0, 1.5, 0)
AfkFrame.Position = UDim2.new(-0.25, 0, -0.25, 0)
AfkFrame.Visible = false
AfkFrame.Text = ""
AfkFrame.AutoButtonColor = false
AfkFrame.ZIndex = 10000 

local StatLayout = Instance.new("UIListLayout", AfkFrame)
StatLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
StatLayout.VerticalAlignment = Enum.VerticalAlignment.Center
StatLayout.Padding = UDim.new(0, 8)

local function createStatLabel(color, size)
    local label = Instance.new("TextLabel", AfkFrame)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 600, 0, 26)
    label.Font = Enum.Font.Code
    label.TextSize = size or 20
    label.TextColor3 = color
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.ZIndex = 10001
    return label
end

local TimeLabel = createStatLabel(Color3.fromRGB(255, 255, 255), 18)      
local RunTimeLabel = createStatLabel(Color3.fromRGB(255, 170, 0), 18)    
local RamLabel = createStatLabel(Color3.fromRGB(240, 240, 240), 15)      
local TempLabel = createStatLabel(Color3.fromRGB(255, 100, 100), 15)     

local Divider = createStatLabel(Color3.fromRGB(50, 50, 50), 12)
Divider.Text = "--------------------------------------------"

local LevelLabel = createStatLabel(Color3.fromRGB(255, 215, 0), 22)
local SpeedLabel = createStatLabel(Color3.fromRGB(0, 255, 255), 22)
local RebirthLabel = createStatLabel(Color3.fromRGB(255, 0, 255), 22)
local WinLabel = createStatLabel(Color3.fromRGB(0, 255, 100), 22)

local NoteLabel = Instance.new("TextLabel", AfkFrame)
NoteLabel.BackgroundTransparency = 1
NoteLabel.Size = UDim2.new(0, 500, 0, 40)
NoteLabel.Font = Enum.Font.SourceSansItalic
NoteLabel.Text = "\n[ Click bất kỳ đâu để TẮT chế độ AFK ]"
NoteLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
NoteLabel.TextSize = 14
NoteLabel.ZIndex = 10001

-- =======================================================
-- HỆ THỐNG ANTI-AFK NGẦM
-- =======================================================
local VirtualUser = game:GetService("VirtualUser")
local player = game.Players.LocalPlayer

player.Idled:Connect(function()
    if _G.AutoSpeed or _G.AutoWin or _G.AutoRebirth then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

-- =======================================================
-- HÀM RÚT GỌN SỐ VÔ CỰC (Infinite Shortening)
-- =======================================================
local suffixes = {"", "K", "M", "B", "T", "Q", "QN", "SX", "SP", "O", "N", "D"}
local function formatNumber(value)
    value = tonumber(value) or 0
    if value == 0 then return "0" end
    local absValue = math.abs(value)
    local sign = value < 0 and "-" or ""
    local i = math.floor(math.log10(absValue) / 3) + 1
    if i > #suffixes then
        return string.format("%s%.2fe%d", sign, absValue / (10 ^ ((#suffixes - 1) * 3)), math.floor(math.log10(absValue)))
    end
    if i <= 1 then
        return sign .. tostring(absValue)
    else
        return string.format("%s%.2f%s", sign, absValue / (10 ^ ((i - 1) * 3)), suffixes[i])
    end
end

-- =======================================================
-- LOGIC QUẢN LÝ TRẠNG THÁI & ĐA LUỒNG NGẦM
-- =======================================================
_G.AutoSpeed = false
_G.AutoWin = false
_G.AutoRebirth = false

local TargetCFrame = CFrame.new(-392.102631, 171.204437, -4761.03857)
local afkStartTime = 0
local startStats = {Level = 0, Speed = 0, Rebirths = 0, Wins = 0}

local function formatElapsedTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d giờ %02d phút %02d giây", hours, minutes, secs)
end

-- Vòng lặp cập nhật thông tin màn hình AFK
task.spawn(function()
    while true do
        if AfkFrame.Visible then
            local now = os.date("*t")
            TimeLabel.Text = string.format("📅 Ngày: %02d/%02d/%04d  |  ⏰ Giờ: %02d:%02d:%02d", now.day, now.month, now.year, now.hour, now.min, now.sec)
            RunTimeLabel.Text = "⏳ ĐÃ TREO MÁY: " .. formatElapsedTime(os.time() - afkStartTime)
            
            local clientRam = game:GetService("Stats"):GetTotalMemoryUsageMb()
            RamLabel.Text = string.format("📦 ROBLOX MEMORY: %.1f MB", clientRam)
            TempLabel.Text = clientRam > 1200 and "🔥 CPU/GPU STATUS: ~72°C (Tải nặng)" or "❄️ CPU/GPU STATUS: ~58°C (Mát mẻ)"
            TempLabel.TextColor3 = clientRam > 1200 and Color3.fromRGB(255, 120, 0) or Color3.fromRGB(0, 255, 150)

            pcall(function()
                local stats = player:WaitForChild("leaderstats")
                LevelLabel.Text = string.format("⭐ LEVEL: %s (+%s)", formatNumber(stats.Level.Value), formatNumber(stats.Level.Value - startStats.Level))
                SpeedLabel.Text = string.format("⚡ SPEED: %s (+%s)", formatNumber(stats.Speed.Value), formatNumber(stats.Speed.Value - startStats.Speed))
                RebirthLabel.Text = string.format("🔄 REBIRTHS: %s (+%s)", formatNumber(stats.Rebirths.Value), formatNumber(stats.Rebirths.Value - startStats.Rebirths))
                WinLabel.Text = string.format("🏆 WINS: %s (+%s)", formatNumber(stats.Wins.Value), formatNumber(stats.Wins.Value - startStats.Wins))
            end)
        end
        task.wait(0.5)
    end
end)

-- 1. XỬ LÝ AUTO SPEED (Hỗ trợ tùy chỉnh số lượng Luồng)
SpeedBtn.MouseButton1Click:Connect(function()
    _G.AutoSpeed = not _G.AutoSpeed
    if _G.AutoSpeed then
        SpeedBtn.Text = "🔥 AUTO SPEED: ON"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        
        -- Lấy số luồng do người dùng nhập (mặc định là 1 nếu nhập lỗi)
        local threadCount = tonumber(ThreadInput.Text) or 1
        if threadCount < 1 then threadCount = 1 end
        
        -- Kích hoạt chạy đồng thời các luồng song song
        for i = 1, threadCount do
            task.spawn(function()
                local remote = game:GetService("ReplicatedStorage").Events.AddSpeed
                while _G.AutoSpeed do
                    pcall(function() remote:FireServer() end)
                    task.wait()
                end
            end)
        end
        
        -- Luồng dọn dẹp hiệu ứng bụi/lag khi chạy nhanh
        task.spawn(function()
            while _G.AutoSpeed do
                pcall(function()
                    local char = player.Character
                    if char then
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Sparkles") then v.Enabled = false end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    else
        SpeedBtn.Text = "🔥 AUTO SPEED: OFF"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(230, 40, 70)
    end
end)

-- 2. XỬ LÝ AUTO WIN
WinBtn.MouseButton1Click:Connect(function()
    _G.AutoWin = not _G.AutoWin
    if _G.AutoWin then
        WinBtn.Text = "🏆 AUTO WIN: ON"
        WinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        
        task.spawn(function()
            while _G.AutoWin do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Anchored = false
                    hrp.CFrame = TargetCFrame
                    hrp.AssemblyLinearVelocity = Vector3.new(0, -12, 0)
                end
                task.wait(0.05)
            end
        end)
    else
        WinBtn.Text = "🏆 AUTO WIN: OFF"
        WinBtn.BackgroundColor3 = Color3.fromRGB(230, 40, 70)
    end
end)

-- 3. XỬ LÝ AUTO REBIRTH
RebirthBtn.MouseButton1Click:Connect(function()
    _G.AutoRebirth = not _G.AutoRebirth
    if _G.AutoRebirth then
        RebirthBtn.Text = "🔄 AUTO REBIRTH: ON"
        RebirthBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        
        task.spawn(function()
            while _G.AutoRebirth do
                pcall(function() game:GetService("ReplicatedStorage").Events.RequestRebirth:InvokeServer() end)
                task.wait(0.5)
            end
        end)
    else
        RebirthBtn.Text = "🔄 AUTO REBIRTH: OFF"
        RebirthBtn.BackgroundColor3 = Color3.fromRGB(230, 40, 70)
    end
end)

-- Sự kiện bật tắt màn hình AFK
AfkOpenBtn.MouseButton1Click:Connect(function()
    afkStartTime = os.time()
    pcall(function()
        local stats = player:WaitForChild("leaderstats")
        startStats.Level = stats.Level.Value
        startStats.Speed = stats.Speed.Value
        startStats.Rebirths = stats.Rebirths.Value
        startStats.Wins = stats.Wins.Value
    end)
    AfkFrame.Visible = true
    MainFrame.Visible = false
end)

AfkFrame.MouseButton1Click:Connect(function()
    AfkFrame.Visible = false
    MainFrame.Visible = true
end)
