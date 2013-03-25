<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecommendationsForm.ascx.cs" Inherits="LINQControls_ControlTemplates_RecommendationsForm" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<style type="text/css">

.RadSlider_Vista.horizontal
{
	height: 14px;
}

.radslider
{
	position: relative; 
	-moz-user-select: none;
	font-size:1px;
	line-height:1px;	
}

.RadSlider_Vista.horizontal .decrease
{
	background-position: 0 0;
}

.radslider.horizontal .decrease
{
	float: left; 
}

.RadSlider_Vista.horizontal .track
{
	left: 10px; top: 0;
	margin-top: 6px;
	height: 4px; line-height: 4px;
	background: url('mvwres://Telerik.Web.UI, Version=2008.2.826.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Vista.Slider.TrackBgr.gif') repeat-x;
}

.radslider .track
{
	position: absolute; 
}

.RadSlider_Vista.horizontal .selectedregion
{
	height: 4px; line-height: 4px;
	background: url('mvwres://Telerik.Web.UI, Version=2008.2.826.35, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Vista.Slider.SelectedRegionHorizontalBgr.gif') right top no-repeat;
}

.radslider .selectedregion
{
	top:0;
	left:0;
}

.radslider .selectedregion
{
	position: absolute; 
}

.radslider .draghandle
{
	position: absolute; 
}

.RadSlider_Vista.horizontal .increase
{
	background-position: -10px 0;
}

.radslider.horizontal .increase
{
	float: right; 
}
    </style>
<script type="text/javascript">
                function HandleValueChange(sender, eventArgs)
                {
                    $get("sliderValue").value = sender.get_value();
                }
            </script>
 <asp:Label ID="statusLabel" runat="server" ForeColor="Red"></asp:Label>
<br />
  <table class="style1" >
            <tr>
        <asp:TextBox ID="ProductIDTextBox" runat="server" Visible="false" ></asp:TextBox>
           
            <asp:TextBox ID="DateInsertedTextBox" runat="server" Visible="false" 
             />
                <td>
                    Title:</td>
                <td>
                    <asp:TextBox ID="TitleTextBox" runat="server"  
                        Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Description:</td>
                <td>
                    <telerik:RadEditor ID="DescriptionRadEditor" Runat="server" 
                        Skin="Vista" EditModes="Design" 
                        Height="300px" Width="500px">
                        <Tools>
                            <telerik:EditorToolGroup>
                                <telerik:EditorTool Name="Bold" Text="Bold" />
                                <telerik:EditorTool Name="Italic" Text="Italic" />
                                <telerik:EditorTool Name="Underline" Text="Underline" />
                            </telerik:EditorToolGroup>
                            <telerik:EditorToolGroup>
                                <telerik:EditorTool Name="Cut" />
                                <telerik:EditorTool Name="Paste" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content>
</Content>
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Rating:</td>
                <td>
                    <telerik:RadSlider ID="Rating1" runat="server" Enabled="True" Length="190" 
                        MaximumValue="5" MinimumValue="1" OnClientLoaded="HandleValueChange" 
                        OnClientValueChange="HandleValueChange" SelectionEnd="1" SelectionStart="1" 
                        Skin="Web20"  Width="190px" />
                        <br />
                        <input type="text" style="width:30px;" id="sliderValue" visible="false"/>

                </td>
            </tr>
            <tr>
            <td>
            <asp:TextBox ID="UserNameTextBox" runat="server" Visible="false" /> 
            </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:Button ID="InsertButton" runat="server" Text="Insert" 
    onclick="InsertButton_Click" />
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Back to Product" />
