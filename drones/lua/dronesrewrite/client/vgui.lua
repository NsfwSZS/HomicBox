DRONES_REWRITE.Colors = { }

DRONES_REWRITE.Colors.Grey = Color(70, 70, 70, 255)
DRONES_REWRITE.Colors.DarkGrey = Color(32, 32, 32, 255)
DRONES_REWRITE.Colors.DarkGrey2 = Color(50, 50, 50, 255)
DRONES_REWRITE.Colors.DarkGrey3 = Color(80, 80, 80, 255)
DRONES_REWRITE.Colors.LightGrey = Color(200, 200, 200, 255)

DRONES_REWRITE.Colors.LightRed = Color(255, 180, 180)
DRONES_REWRITE.Colors.DarkRed = Color(150, 50, 50)

DRONES_REWRITE.Colors.DarkBlue = Color(30, 110, 110)
DRONES_REWRITE.Colors.LightBlue = Color(30, 130, 205)

DRONES_REWRITE.Colors.Green = Color(30, 200, 30)
DRONES_REWRITE.Colors.Red = Color(200, 30, 30)

DRONES_REWRITE.Colors.Border = Color(20, 20, 20, 255)

DRONES_REWRITE.CreateLabel = function(text, x, y, parent)
	local lab = vgui.Create("DLabel", parent)
	lab:SetPos(x, y)
	lab:SetText(text)
	lab:SetFont("DronesRewrite_customfont1")
	lab:SizeToContents()

	return lab
end

DRONES_REWRITE.CreateWindow = function(w, h)
	local win = vgui.Create("DFrame")
	win:SetSize(w, h)
	win:Center()
	win:SetTitle("")
	win:ShowCloseButton(false)
	win:MakePopup()

	function win:Paint()
		local w, h = self:GetWide(), self:GetTall()
		draw.RoundedBox(0, 0, 0, w, h, DRONES_REWRITE.Colors.Grey)
		draw.RoundedBox(0, 0, 0, w, 25, DRONES_REWRITE.Colors.DarkGrey2)
	end
	
	function win:OnCloseButton()
	end

	function win:SetupCloseButton()
		if IsValid(self.CloseBtn) then self.CloseBtn:Remove() end
		local w, h = self:GetWide(), self:GetTall()

		local close = vgui.Create("DButton", self)
		close:SetPos(w - 25, 0)
		close:SetSize(25, 25)
		close:SetText("")
		close.DoClick = function()
			if self:OnCloseButton() then return end
			self:Close()
		end
		close.Paint = function(close, w, h)
			surface.SetMaterial(Material("stuff/cross"))
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawTexturedRect(6, 6, w - 12, h - 12)
		end

		self.CloseBtn = close
	end

	win:SetupCloseButton()

	return win
end

DRONES_REWRITE.CreateScrollPanel = function(x, y, w, h, win)
	local panel = vgui.Create("DScrollPanel", win)
	panel:SetPos(x, y)
	panel:SetSize(w, h)

	panel:GetVBar():SetWide(10)

	panel:GetVBar().btnUp.Paint = function(self)
		local w, h = self:GetWide(), self:GetTall()

		surface.SetMaterial(Material("stuff/arrow"))
		surface.SetDrawColor(Color(255, 255, 255))
		surface.DrawTexturedRectRotated(w / 2, h / 2, w, h, 90)
	end

	panel:GetVBar().btnDown.Paint = function(self)
		local w, h = self:GetWide(), self:GetTall()

		surface.SetMaterial(Material("stuff/arrow"))
		surface.SetDrawColor(Color(255, 255, 255))
		surface.DrawTexturedRectRotated(w / 2, h / 2, w, h, -90)
	end

	panel:GetVBar().Paint = function()
	end

	panel:GetVBar().btnGrip.Paint = function(self)
		local w, h = self:GetWide(), self:GetTall()

		local col = DRONES_REWRITE.Colors.LightGrey
		draw.RoundedBox(0, 0, 0, w, h, Color(col.r, col.g, col.b, 100))
	end

	local old = panel.PerformLayout
	function panel:PerformLayout()
		old(self)
		self.pnlCanvas:SetWide(self:GetWide())
	end

	return panel
end

DRONES_REWRITE.CreateButton = function(text, x, y, w, h, win, doclick)
	local btn = vgui.Create("DButton", win)
	btn:SetText(text)
	btn:SetPos(x, y)
	btn:SetSize(w, h)
	btn:SetFont("DronesRewrite_customfont1")
	btn:SetColor(Color(255, 255, 255)) -- Color for label

	btn.EntColor = DRONES_REWRITE.Colors.LightBlue
	btn.StaticColor = DRONES_REWRITE.Colors.DarkGrey

	function btn:Paint()
		local w, h = self:GetWide(), self:GetTall()

		local color = self.entered and self.EntColor or self.StaticColor
		draw.RoundedBox(0, 0, 0, w, h, color)
	end

	function btn:SetEnterColor(color) self.EntColor = color end
	function btn:SetStaticColor(color) self.StaticColor = color end
	
	function btn:OnCursorEntered() self.entered = true end
	function btn:OnCursorExited() self.entered = false end

	btn.DoClick = doclick

	return btn
end