pageextension 50122 BlanketPOArchiveSubform extends "Blanket Purch. Order Arch.Sub."
{
    layout
    {
        modify("Item Reference No.") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify("Expected Receipt Date") { Visible = false; }
        modify("Planned Receipt Date") { Visible = false; }
        modify("Order Date") { Visible = false; }

        modify("Shortcut Dimension 1 Code") { Visible = false; }
        modify("Shortcut Dimension 2 Code") { Visible = false; }
        modify(ShortcutDimCode3) { Visible = false; }
        modify(ShortcutDimCode4) { Visible = false; }
        modify(ShortcutDimCode5) { Visible = false; }
        modify(ShortcutDimCode6) { Visible = false; }
        modify(ShortcutDimCode7) { Visible = false; }
        modify(ShortcutDimCode8) { Visible = false; }
    }
}