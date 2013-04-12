<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProfileSignUpUserControl.ascx.cs" Inherits="Sandbox_ProfileSignUpUserControl" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

        <div style="float: left; width: auto">

        <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblTitle" runat="server" Text="Billing Information" 
                        Style="font-weight: bold; font-size: large;"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    First Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="BillFNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="BillFNTB" Display="Dynamic" 
                        ErrorMessage="Billing First Name Required" 
                        ToolTip="Billing First Name Required">*</asp:RequiredFieldValidator>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Last Name:</td>
                <td>
                    <telerik:RadTextBox ID="BillLNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="BillLNTB" ErrorMessage="Billing Last Name Required" 
                        ToolTip="Billing Last Name Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Middle Name:</td>
                <td>
                    <telerik:RadTextBox ID="BillMNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Nick Name:</td>
                <td>
                    <telerik:RadTextBox ID="BillNNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Prefix:</td>
                <td>
                    <telerik:RadComboBox ID="BillPrefixCombo" Runat="server" Skin="Vista">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="True" Text="[Select One]" 
                                Value="[Select One]" />
                            <telerik:RadComboBoxItem runat="server" Text="Mr." Value="Mr." />
                            <telerik:RadComboBoxItem runat="server" Text="Ms." Value="Ms." />
                            <telerik:RadComboBoxItem runat="server" Text="Mrs." Value="Mrs." />
                        </Items>
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Address:
                </td>
                <td>
                    <telerik:RadTextBox ID="BillAdTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="BillAdTB" Display="Dynamic" 
                        ErrorMessage="Billing Address Required" ToolTip="Billing Address Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Address 2 (Apt, PO Box, etc.)</td>
                <td>
                    <telerik:RadTextBox ID="BillAd2TB" Runat="server" Width="125px" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    City
                </td>
                <td>
                    <telerik:RadTextBox ID="BillCityTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="BillCityTB" Display="Dynamic" 
                        ErrorMessage="Billing City Required" ToolTip="Billing City Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Country</td>
                <td>
                <telerik:RadComboBox ID="BillCountryDropDown" Skin="Vista" Runat="server" 
                        MarkFirstMatch="True" 
                        >
        <Items>
                                            <telerik:RadComboBoxItem Text="AFGHANISTAN" Value="AFGHANISTAN" />
                                            <telerik:RadComboBoxItem Text="ÅLAND ISLANDS" Value="ÅLAND ISLANDS" />
                                            <telerik:RadComboBoxItem Text="ALBANIA" Value="ALBANIA" />
                                            <telerik:RadComboBoxItem Text="ALGERIA" Value="ALGERIA" />
                                            <telerik:RadComboBoxItem Text="AMERICAN SAMOA" Value="AMERICAN SAMOA" />
                                            <telerik:RadComboBoxItem Text="ANDORRA" Value="ANDORRA" />
                                            <telerik:RadComboBoxItem Text="ANGOLA" Value="ANGOLA" />
                                            <telerik:RadComboBoxItem Text="ANGUILLA" Value="ANGUILLA" />
                                            <telerik:RadComboBoxItem Text="ANTARCTICA" Value="ANTARCTICA" />
                                            <telerik:RadComboBoxItem Text="ANTIGUA AND BARBUDA" Value="ANTIGUA AND BARBUDA" />
                                            <telerik:RadComboBoxItem Text="ARGENTINA" Value="ARGENTINA" />
                                            <telerik:RadComboBoxItem Text="ARMENIA" Value="ARMENIA" />
                                            <telerik:RadComboBoxItem Text="ARUBA" Value="ARUBA" />
                                            <telerik:RadComboBoxItem Text="AUSTRALIA" Value="AUSTRALIA" />
                                            <telerik:RadComboBoxItem Text="AUSTRIA" Value="AUSTRIA" />
                                            <telerik:RadComboBoxItem Text="AZERBAIJAN" Value="AZERBAIJAN" />
                                            <telerik:RadComboBoxItem Text="BAHAMAS" Value="BAHAMAS" />
                                            <telerik:RadComboBoxItem Text="BAHRAIN" Value="BAHRAIN" />
                                            <telerik:RadComboBoxItem Text="BANGLADESH" Value="BANGLADESH" />
                                            <telerik:RadComboBoxItem Text="BARBADOS" Value="BARBADOS" />
                                            <telerik:RadComboBoxItem Text="BELARUS" Value="BELARUS" />
                                            <telerik:RadComboBoxItem Text="BELGIUM" Value="BELGIUM" />
                                            <telerik:RadComboBoxItem Text="BELIZE" Value="BELIZE" />
                                            <telerik:RadComboBoxItem Text="BENIN" Value="BENIN" />
                                            <telerik:RadComboBoxItem Text="BERMUDA" Value="BERMUDA" />
                                            <telerik:RadComboBoxItem Text="BHUTAN" Value="BHUTAN" />
                                            <telerik:RadComboBoxItem Text="BOLIVIA" Value="BOLIVIA" />
                                            <telerik:RadComboBoxItem Text="BOSNIA AND HERZEGOVINA" Value="BOSNIA AND HERZEGOVINA" />
                                            <telerik:RadComboBoxItem Text="BOTSWANA" Value="BOTSWANA" />
                                            <telerik:RadComboBoxItem Text="BOUVET ISLAND" Value="BOUVET ISLAND" />
                                            <telerik:RadComboBoxItem Text="BRAZIL" Value="BRAZIL" />
                                            <telerik:RadComboBoxItem Text="BRITISH INDIAN OCEAN TERRITORY" Value="BRITISH INDIAN OCEAN TERRITORY" />
                                            <telerik:RadComboBoxItem Text="BRUNEI DARUSSALAM" Value="BRUNEI DARUSSALAM" />
                                            <telerik:RadComboBoxItem Text="BULGARIA" Value="BULGARIA" />
                                            <telerik:RadComboBoxItem Text="BURKINA FASO" Value="BURKINA FASO" />
                                            <telerik:RadComboBoxItem Text="BURUNDI" Value="BURUNDI" />
                                            <telerik:RadComboBoxItem Text="CAMBODIA" Value="CAMBODIA" />
                                            <telerik:RadComboBoxItem Text="CAMEROON" Value="CAMEROON" />
                                            <telerik:RadComboBoxItem Text="CANADA" Value="CANADA" />
                                            <telerik:RadComboBoxItem Text="CAPE VERDE" Value="CAPE VERDE" />
                                            <telerik:RadComboBoxItem Text="CAYMAN ISLANDS" Value="CAYMAN ISLANDS" />
                                            <telerik:RadComboBoxItem Text="CENTRAL AFRICAN REPUBLIC" Value="CENTRAL AFRICAN REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="CHAD" Value="CHAD" />
                                            <telerik:RadComboBoxItem Text="CHILE" Value="CHILE" />
                                            <telerik:RadComboBoxItem Text="CHINA" Value="CHINA" />
                                            <telerik:RadComboBoxItem Text="CHRISTMAS ISLAND" Value="CHRISTMAS ISLAND" />
                                            <telerik:RadComboBoxItem Text="COCOS (KEELING) ISLANDS" Value="COCOS (KEELING) ISLANDS" />
                                            <telerik:RadComboBoxItem Text="COLOMBIA" Value="COLOMBIA" />
                                            <telerik:RadComboBoxItem Text="COMOROS" Value="COMOROS" />
                                            <telerik:RadComboBoxItem Text="CONGO" Value="CONGO" />
                                            <telerik:RadComboBoxItem Text="CONGO, THE DEMOCRATIC REPUBLIC OF THE" Value="CONGO" />
                                            <telerik:RadComboBoxItem Text="COOK ISLANDS" Value="COOK ISLANDS" />
                                            <telerik:RadComboBoxItem Text="COSTA RICA" Value="COSTA RICA" />
                                            <telerik:RadComboBoxItem Text="CÔTE D'IVOIRE" Value="CÔTE D'IVOIRE" />
                                            <telerik:RadComboBoxItem Text="CROATIA" Value="CROATIA" />
                                            <telerik:RadComboBoxItem Text="CUBA" Value="CUBA" />
                                            <telerik:RadComboBoxItem Text="CYPRUS" Value="CYPRUS" />
                                            <telerik:RadComboBoxItem Text="CZECH REPUBLIC" Value="CZECH REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="DENMARK" Value="DENMARK" />
                                            <telerik:RadComboBoxItem Text="DJIBOUTI" Value="DJIBOUTI" />
                                            <telerik:RadComboBoxItem Text="DOMINICA" Value="DOMINICA" />
                                            <telerik:RadComboBoxItem Text="DOMINICAN REPUBLIC" Value="DOMINICAN REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="ECUADOR" Value="ECUADOR" />
                                            <telerik:RadComboBoxItem Text="EGYPT" Value="EGYPT" />
                                            <telerik:RadComboBoxItem Text="EL SALVADOR" Value="EL SALVADOR" />
                                            <telerik:RadComboBoxItem Text="EQUATORIAL GUINEA" Value="EQUATORIAL GUINEA" />
                                            <telerik:RadComboBoxItem Text="ERITREA" Value="ERITREA" />
                                            <telerik:RadComboBoxItem Text="ESTONIA" Value="ESTONIA" />
                                            <telerik:RadComboBoxItem Text="ETHIOPIA" Value="ETHIOPIA" />
                                            <telerik:RadComboBoxItem Text="FALKLAND ISLANDS (MALVINAS)" Value="FALKLAND ISLANDS (MALVINAS)" />
                                            <telerik:RadComboBoxItem Text="FAROE ISLANDS" Value="FAROE ISLANDS" />
                                            <telerik:RadComboBoxItem Text="FIJI" Value="FIJI" />
                                            <telerik:RadComboBoxItem Text="FINLAND" Value="FINLAND" />
                                            <telerik:RadComboBoxItem Text="FRANCE" Value="FRANCE" />
                                            <telerik:RadComboBoxItem Text="FRENCH GUIANA" Value="FRENCH GUIANA" />
                                            <telerik:RadComboBoxItem Text="FRENCH POLYNESIA" Value="FRENCH POLYNESIA" />
                                            <telerik:RadComboBoxItem Text="FRENCH SOUTHERN TERRITORIES" Value="FRENCH SOUTHERN TERRITORIES" />
                                            <telerik:RadComboBoxItem Text="GABON" Value="GABON" />
                                            <telerik:RadComboBoxItem Text="GAMBIA" Value="GAMBIA" />
                                            <telerik:RadComboBoxItem Text="GEORGIA" Value="GEORGIA" />
                                            <telerik:RadComboBoxItem Text="GERMANY" Value="GERMANY" />
                                            <telerik:RadComboBoxItem Text="GHANA" Value="GHANA" />
                                            <telerik:RadComboBoxItem Text="GIBRALTAR" Value="GIBRALTAR" />
                                            <telerik:RadComboBoxItem Text="GREECE" Value="GREECE" />
                                            <telerik:RadComboBoxItem Text="GREENLAND" Value="GREENLAND" />
                                            <telerik:RadComboBoxItem Text="GRENADA" Value="GRENADA" />
                                            <telerik:RadComboBoxItem Text="GUADELOUPE" Value="GUADELOUPE" />
                                            <telerik:RadComboBoxItem Text="GUAM" Value="GUAM" />
                                            <telerik:RadComboBoxItem Text="GUATEMALA" Value="GUATEMALA" />
                                            <telerik:RadComboBoxItem Text="GUERNSEY" Value="GUERNSEY" />
                                            <telerik:RadComboBoxItem Text="GUINEA" Value="GUINEA" />
                                            <telerik:RadComboBoxItem Text="GUINEA-BISSAU" Value="GUINEA-BISSAU" />
                                            <telerik:RadComboBoxItem Text="GUYANA" Value="GUYANA" />
                                            <telerik:RadComboBoxItem Text="HAITI" Value="HAITI" />
                                            <telerik:RadComboBoxItem Text="HEARD ISLAND AND MCDONALD ISLANDS" Value="HEARD ISLAND AND MCDONALD ISLANDS" />
                                            <telerik:RadComboBoxItem Text="HOLY SEE (VATICAN CITY STATE)" Value="HOLY SEE (VATICAN CITY STATE)" />
                                            <telerik:RadComboBoxItem Text="HONDURAS" Value="HONDURAS" />
                                            <telerik:RadComboBoxItem Text="HONG KONG" Value="HONG KONG" />
                                            <telerik:RadComboBoxItem Text="HUNGARY" Value="HUNGARY" />
                                            <telerik:RadComboBoxItem Text="ICELAND" Value="ICELAND" />
                                            <telerik:RadComboBoxItem Text="INDIA" Value="INDIA" />
                                            <telerik:RadComboBoxItem Text="INDONESIA" Value="INDONESIA" />
                                            <telerik:RadComboBoxItem Text="IRAN, ISLAMIC REPUBLIC OF" Value="IRAN" />
                                            <telerik:RadComboBoxItem Text="IRAQ" Value="IRAQ" />
                                            <telerik:RadComboBoxItem Text="IRELAND" Value="IRELAND" />
                                            <telerik:RadComboBoxItem Text="ISLE OF MAN" Value="ISLE OF MAN" />
                                            <telerik:RadComboBoxItem Text="ISRAEL" Value="ISRAEL" />
                                            <telerik:RadComboBoxItem Text="ITALY" Value="ITALY" />
                                            <telerik:RadComboBoxItem Text="JAMAICA" Value="JAMAICA" />
                                            <telerik:RadComboBoxItem Text="JAPAN" Value="JAPAN" />
                                            <telerik:RadComboBoxItem Text="JERSEY" Value="JERSEY" />
                                            <telerik:RadComboBoxItem Text="JORDAN" Value="JORDAN" />
                                            <telerik:RadComboBoxItem Text="KAZAKHSTAN" Value="KAZAKHSTAN" />
                                            <telerik:RadComboBoxItem Text="KENYA" Value="KENYA" />
                                            <telerik:RadComboBoxItem Text="KIRIBATI" Value="KIRIBATI" />
                                            <telerik:RadComboBoxItem Text="KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF" Value="KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="KOREA, REPUBLIC OF" Value="KOREA, REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="KUWAIT" Value="KUWAIT" />
                                            <telerik:RadComboBoxItem Text="KYRGYZSTAN" Value="KYRGYZSTAN" />
                                            <telerik:RadComboBoxItem Text="LAO PEOPLE'S DEMOCRATIC REPUBLIC" Value="LAO PEOPLE'S DEMOCRATIC REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="LATVIA" Value="LATVIA" />
                                            <telerik:RadComboBoxItem Text="LEBANON" Value="LEBANON" />
                                            <telerik:RadComboBoxItem Text="LESOTHO" Value="LESOTHO" />
                                            <telerik:RadComboBoxItem Text="LIBERIA" Value="LIBERIA" />
                                            <telerik:RadComboBoxItem Text="LIBYAN ARAB JAMAHIRIYA" Value="LIBYAN ARAB JAMAHIRIYA" />
                                            <telerik:RadComboBoxItem Text="LIECHTENSTEIN" Value="LIECHTENSTEIN" />
                                            <telerik:RadComboBoxItem Text="LITHUANIA" Value="LITHUANIA" />
                                            <telerik:RadComboBoxItem Text="LUXEMBOURG" Value="LUXEMBOURG" />
                                            <telerik:RadComboBoxItem Text="MACAO" Value="MACAO" />
                                            <telerik:RadComboBoxItem Text="MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF" Value="MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="MADAGASCAR" Value="MADAGASCAR" />
                                            <telerik:RadComboBoxItem Text="MALAWI" Value="MALAWI" />
                                            <telerik:RadComboBoxItem Text="MALAYSIA" Value="MALAYSIA" />
                                            <telerik:RadComboBoxItem Text="MALDIVES" Value="MALDIVES" />
                                            <telerik:RadComboBoxItem Text="MALI" Value="MALI" />
                                            <telerik:RadComboBoxItem Text="MALTA" Value="MALTA" />
                                            <telerik:RadComboBoxItem Text="MARSHALL ISLANDS" Value="MARSHALL ISLANDS" />
                                            <telerik:RadComboBoxItem Text="MARTINIQUE" Value="MARTINIQUE" />
                                            <telerik:RadComboBoxItem Text="MAURITANIA" Value="MAURITANIA" />
                                            <telerik:RadComboBoxItem Text="MAURITIUS" Value="MAURITIUS" />
                                            <telerik:RadComboBoxItem Text="MAYOTTE" Value="MAYOTTE" />
                                            <telerik:RadComboBoxItem Text="MEXICO" Value="MEXICO" />
                                            <telerik:RadComboBoxItem Text="MICRONESIA, FEDERATED STATES OF" Value="MICRONESIA, FEDERATED STATES OF" />
                                            <telerik:RadComboBoxItem Text="MOLDOVA, REPUBLIC OF" Value="MOLDOVA, REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="MONACO" Value="MONACO" />
                                            <telerik:RadComboBoxItem Text="MONGOLIA" Value="MONGOLIA" />
                                            <telerik:RadComboBoxItem Text="MONTENEGRO" Value="MONTENEGRO" />
                                            <telerik:RadComboBoxItem Text="MONTSERRAT" Value="MONTSERRAT" />
                                            <telerik:RadComboBoxItem Text="MOROCCO" Value="MOROCCO" />
                                            <telerik:RadComboBoxItem Text="MOZAMBIQUE" Value="MOZAMBIQUE" />
                                            <telerik:RadComboBoxItem Text="MYANMAR" Value="MYANMAR" />
                                            <telerik:RadComboBoxItem Text="NAMIBIA" Value="NAMIBIA" />
                                            <telerik:RadComboBoxItem Text="NAURU" Value="NAURU" />
                                            <telerik:RadComboBoxItem Text="NEPAL" Value="NEPAL" />
                                            <telerik:RadComboBoxItem Text="NETHERLANDS" Value="NETHERLANDS" />
                                            <telerik:RadComboBoxItem Text="NETHERLANDS ANTILLES" Value="NETHERLANDS ANTILLES" />
                                            <telerik:RadComboBoxItem Text="NEW CALEDONIA" Value="NEW CALEDONIA" />
                                            <telerik:RadComboBoxItem Text="NEW ZEALAND" Value="NEW ZEALAND" />
                                            <telerik:RadComboBoxItem Text="NICARAGUA" Value="NICARAGUA" />
                                            <telerik:RadComboBoxItem Text="NIGER" Value="NIGER" />
                                            <telerik:RadComboBoxItem Text="NIGERIA" Value="NIGERIA" />
                                            <telerik:RadComboBoxItem Text="NIUE" Value="NIUE" />
                                            <telerik:RadComboBoxItem Text="NORFOLK ISLAND" Value="NORFOLK ISLAND" />
                                            <telerik:RadComboBoxItem Text="NORTHERN MARIANA ISLANDS" Value="NORTHERN MARIANA ISLANDS" />
                                            <telerik:RadComboBoxItem Text="NORWAY" Value="NORWAY" />
                                            <telerik:RadComboBoxItem Text="OMAN" Value="OMAN" />
                                            <telerik:RadComboBoxItem Text="PAKISTAN" Value="PAKISTAN" />
                                            <telerik:RadComboBoxItem Text="PALAU" Value="PALAU" />
                                            <telerik:RadComboBoxItem Text="PALESTINIAN TERRITORY, OCCUPIED" Value="PALESTINIAN TERRITORY, OCCUPIED" />
                                            <telerik:RadComboBoxItem Text="PANAMA" Value="PANAMA" />
                                            <telerik:RadComboBoxItem Text="PAPUA NEW GUINEA" Value="PAPUA NEW GUINEA" />
                                            <telerik:RadComboBoxItem Text="PARAGUAY" Value="PARAGUAY" />
                                            <telerik:RadComboBoxItem Text="PERU" Value="PERU" />
                                            <telerik:RadComboBoxItem Text="PHILIPPINES" Value="PHILIPPINES" />
                                            <telerik:RadComboBoxItem Text="PITCAIRN" Value="PITCAIRN" />
                                            <telerik:RadComboBoxItem Text="POLAND" Value="POLAND" />
                                            <telerik:RadComboBoxItem Text="PORTUGAL" Value="PORTUGAL" />
                                            <telerik:RadComboBoxItem Text="PUERTO RICO" Value="PUERTO RICO" />
                                            <telerik:RadComboBoxItem Text="QATAR" Value="QATAR" />
                                            <telerik:RadComboBoxItem Text="RÉUNION" Value="RÉUNION" />
                                            <telerik:RadComboBoxItem Text="ROMANIA" Value="ROMANIA" />
                                            <telerik:RadComboBoxItem Text="RUSSIAN FEDERATION" Value="RUSSIAN FEDERATION" />
                                            <telerik:RadComboBoxItem Text="RWANDA" Value="RWANDA" />
                                            <telerik:RadComboBoxItem Text="SAINT BARTHÉLEMY" Value="SAINT BARTHÉLEMY" />
                                            <telerik:RadComboBoxItem Text="SAINT HELENA" Value="SAINT HELENA" />
                                            <telerik:RadComboBoxItem Text="SAINT KITTS AND NEVIS" Value="SAINT KITTS AND NEVIS" />
                                            <telerik:RadComboBoxItem Text="SAINT LUCIA" Value="SAINT LUCIA" />
                                            <telerik:RadComboBoxItem Text="SAINT MARTIN" Value="SAINT MARTIN" />
                                            <telerik:RadComboBoxItem Text="SAINT PIERRE AND MIQUELON" Value="SAINT PIERRE AND MIQUELON" />
                                            <telerik:RadComboBoxItem Text="SAINT VINCENT AND THE GRENADINES" Value="SAINT VINCENT AND THE GRENADINES" />
                                            <telerik:RadComboBoxItem Text="SAMOA" Value="SAMOA" />
                                            <telerik:RadComboBoxItem Text="SAN MARINO" Value="SAN MARINO" />
                                            <telerik:RadComboBoxItem Text="SAO TOME AND PRINCIPE" Value="SAO TOME AND PRINCIPE" />
                                            <telerik:RadComboBoxItem Text="SAUDI ARABIA" Value="SAUDI ARABIA" />
                                            <telerik:RadComboBoxItem Text="SENEGAL" Value="SENEGAL" />
                                            <telerik:RadComboBoxItem Text="SERBIA" Value="SERBIA" />
                                            <telerik:RadComboBoxItem Text="SEYCHELLES" Value="SEYCHELLES" />
                                            <telerik:RadComboBoxItem Text="SIERRA LEONE" Value="SIERRA LEONE" />
                                            <telerik:RadComboBoxItem Text="SINGAPORE" Value="SINGAPORE" />
                                            <telerik:RadComboBoxItem Text="SLOVAKIA" Value="SLOVAKIA" />
                                            <telerik:RadComboBoxItem Text="SLOVENIA" Value="SLOVENIA" />
                                            <telerik:RadComboBoxItem Text="SOLOMON ISLANDS" Value="SOLOMON ISLANDS" />
                                            <telerik:RadComboBoxItem Text="SOMALIA" Value="SOMALIA" />
                                            <telerik:RadComboBoxItem Text="SOUTH AFRICA" Value="SOUTH AFRICA" />
                                            <telerik:RadComboBoxItem Text="SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS" Value="SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS" />
                                            <telerik:RadComboBoxItem Text="SPAIN" Value="SPAIN" />
                                            <telerik:RadComboBoxItem Text="SRI LANKA" Value="SRI LANKA" />
                                            <telerik:RadComboBoxItem Text="SUDAN" Value="SUDAN" />
                                            <telerik:RadComboBoxItem Text="SURINAME" Value="SURINAME" />
                                            <telerik:RadComboBoxItem Text="SVALBARD AND JAN MAYEN" Value="SVALBARD AND JAN MAYEN" />
                                            <telerik:RadComboBoxItem Text="SWAZILAND" Value="SWAZILAND" />
                                            <telerik:RadComboBoxItem Text="SWEDEN" Value="SWEDEN" />
                                            <telerik:RadComboBoxItem Text="SWITZERLAND" Value="SWITZERLAND" />
                                            <telerik:RadComboBoxItem Text="SYRIAN ARAB REPUBLIC" Value="SYRIAN ARAB REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="TAIWAN, PROVINCE OF CHINA" Value="TAIWAN, PROVINCE OF CHINA" />
                                            <telerik:RadComboBoxItem Text="TAJIKISTAN" Value="TAJIKISTAN" />
                                            <telerik:RadComboBoxItem Text="TANZANIA, UNITED REPUBLIC OF" Value="TANZANIA, UNITED REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="THAILAND" Value="THAILAND" />
                                            <telerik:RadComboBoxItem Text="TIMOR-LESTE" Value="TIMOR-LESTE" />
                                            <telerik:RadComboBoxItem Text="TOGO" Value="TOGO" />
                                            <telerik:RadComboBoxItem Text="TOKELAU" Value="TOKELAU" />
                                            <telerik:RadComboBoxItem Text="TONGA" Value="TONGA" />
                                            <telerik:RadComboBoxItem Text="TRINIDAD AND TOBAGO" Value="TRINIDAD AND TOBAGO" />
                                            <telerik:RadComboBoxItem Text="TUNISIA" Value="TUNISIA" />
                                            <telerik:RadComboBoxItem Text="TURKEY" Value="TURKEY" />
                                            <telerik:RadComboBoxItem Text="TURKMENISTAN" Value="TURKMENISTAN" />
                                            <telerik:RadComboBoxItem Text="TURKS AND CAICOS ISLANDS" Value="TURKS AND CAICOS ISLANDS" />
                                            <telerik:RadComboBoxItem Text="TUVALU" Value="TUVALU" />
                                            <telerik:RadComboBoxItem Text="UGANDA" Value="UGANDA" />
                                            <telerik:RadComboBoxItem Text="UKRAINE" Value="UKRAINE" />
                                            <telerik:RadComboBoxItem Text="UNITED ARAB EMIRATES" Value="UNITED ARAB EMIRATES" />
                                            <telerik:RadComboBoxItem Text="UNITED KINGDOM" Value="UNITED KINGDOM" />
                                            <telerik:RadComboBoxItem Text="UNITED STATES" Value="USA" Selected="True" />
                                            <telerik:RadComboBoxItem Text="UNITED STATES MINOR OUTLYING ISLANDS" Value="UNITED STATES MINOR OUTLYING ISLANDS" />
                                            <telerik:RadComboBoxItem Text="URUGUAY" Value="URUGUAY" />
                                            <telerik:RadComboBoxItem Text="UZBEKISTAN" Value="UZBEKISTAN" />
                                            <telerik:RadComboBoxItem Text="VANUATU" Value="VANUATU" />
                                            <telerik:RadComboBoxItem Text="VATICAN CITY STATE" Value="VATICAN CITY STATE" />
                                            <telerik:RadComboBoxItem Text="VENEZUELA" Value="VENEZUELA" />
                                            <telerik:RadComboBoxItem Text="VIET NAM" Value="VIET NAM" />
                                            <telerik:RadComboBoxItem Text="VIRGIN ISLANDS, BRITISH" Value="VIRGIN ISLANDS, BRITISH" />
                                            <telerik:RadComboBoxItem Text="VIRGIN ISLANDS, U.S." Value="VIRGIN ISLANDS, U.S." />
                                            <telerik:RadComboBoxItem Text="WALLIS AND FUTUNA" Value="WALLIS AND FUTUNA" />
                                            <telerik:RadComboBoxItem Text="WESTERN SAHARA" Value="WESTERN SAHARA" />
                                            <telerik:RadComboBoxItem Text="YEMEN" Value="YEMEN" />
                                            <telerik:RadComboBoxItem Text="ZAIRE, THE DEMOCRATIC REPUBLIC OF THE" Value="ZAIRE, THE DEMOCRATIC REPUBLIC OF THE" />
                                            <telerik:RadComboBoxItem Text="ZAMBIA" Value="ZAMBIA" />
                                            <telerik:RadComboBoxItem Text="ZIMBABWE" Value="ZIMBABWE" />
        </Items>

<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </telerik:RadComboBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    State (U.S. only)</td>
                <td>
    <telerik:RadComboBox ID="BillStateDropDown" Skin="Vista" Runat="server" 
                        MarkFirstMatch="True">
        <Items>
                                            <telerik:RadComboBoxItem Text="-- Select state --" Value="" />
                                            <telerik:RadComboBoxItem Text="Alabama" Value="AL" />
                                            <telerik:RadComboBoxItem Text="Alaska" Value="AK" />
                                            <telerik:RadComboBoxItem Text="Arizona" Value="AZ" />
                                            <telerik:RadComboBoxItem Text="Arkansas" Value="AR" />
                                            <telerik:RadComboBoxItem Text="California" Value="CA" />
                                            <telerik:RadComboBoxItem Text="Colorado" Value="CO" />
                                            <telerik:RadComboBoxItem Text="Connecticut" Value="CT" />
                                            <telerik:RadComboBoxItem Text="Delaware" Value="DE" />
                                            <telerik:RadComboBoxItem Text="District of Columbia" Value="DC" />
                                            <telerik:RadComboBoxItem Text="Florida" Value="FL" />
                                            <telerik:RadComboBoxItem Text="Georgia" Value="GA" />
                                            <telerik:RadComboBoxItem Text="Hawaii" Value="HA" />
                                            <telerik:RadComboBoxItem Text="Idaho" Value="ID" />
                                            <telerik:RadComboBoxItem Text="Illinois" Value="IL" />
                                            <telerik:RadComboBoxItem Text="Indiana" Value="IN" />
                                            <telerik:RadComboBoxItem Text="Iowa" Value="IO" />
                                            <telerik:RadComboBoxItem Text="Kansas" Value="KS" />
                                            <telerik:RadComboBoxItem Text="Kentucky" Value="KY" />
                                            <telerik:RadComboBoxItem Text="Louisiana" Value="LA" />
                                            <telerik:RadComboBoxItem Text="Maine" Value="ME" />
                                            <telerik:RadComboBoxItem Text="Maryland" Value="MD" />
                                            <telerik:RadComboBoxItem Text="Massachusetts" Value="MA" />
                                            <telerik:RadComboBoxItem Text="Michigan" Value="MI" />
                                            <telerik:RadComboBoxItem Text="Minnesota" Value="MN" />
                                            <telerik:RadComboBoxItem Text="Mississippi" Value="MS" />
                                            <telerik:RadComboBoxItem Text="Missouri" Value="MO" />
                                            <telerik:RadComboBoxItem Text="Montana" Value="MT" />
                                            <telerik:RadComboBoxItem Text="Nebraska" Value="NE" />
                                            <telerik:RadComboBoxItem Text="Nevada" Value="NV" />
                                            <telerik:RadComboBoxItem Text="New Hampshire" Value="NH" />
                                            <telerik:RadComboBoxItem Text="New Jersey" Value="NJ" />
                                            <telerik:RadComboBoxItem Text="New Mexico" Value="NM" />
                                            <telerik:RadComboBoxItem Text="New York" Value="NY" />
                                            <telerik:RadComboBoxItem Text="North Carolina" Value="NC" />
                                            <telerik:RadComboBoxItem Text="North Dakota" Value="ND" />
                                            <telerik:RadComboBoxItem Text="Ohio" Value="OH" />
                                            <telerik:RadComboBoxItem Text="Oklahoma" Value="OK" />
                                            <telerik:RadComboBoxItem Text="Oregon" Value="OR" />
                                            <telerik:RadComboBoxItem Text="Pennsylvania" Value="PA" />
                                            <telerik:RadComboBoxItem Text="Rhode Island" Value="RI" />
                                            <telerik:RadComboBoxItem Text="South Carolina" Value="SC" />
                                            <telerik:RadComboBoxItem Text="South Dakota" Value="SD" />
                                            <telerik:RadComboBoxItem Text="Tennessee" Value="TN" />
                                            <telerik:RadComboBoxItem Text="Texas" Value="TX" />
                                            <telerik:RadComboBoxItem Text="Utah" Value="UT" />
                                            <telerik:RadComboBoxItem Text="Vermont" Value="VT" />
                                            <telerik:RadComboBoxItem Text="Virginia" Value="VA" />
                                            <telerik:RadComboBoxItem Text="Washington" Value="WA" />
                                            <telerik:RadComboBoxItem Text="West Virginia" Value="WV" />
                                            <telerik:RadComboBoxItem Text="Wisconsin" Value="WI" />
                                            <telerik:RadComboBoxItem Text="Wyoming" Value="WY" />
          
        </Items>
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
                    </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
            <td>
            Zip Code
            </td>
            <td>
            <telerik:RadMaskedTextBox ID="BillZipCodeTB" Runat="server" 
                        Mask="#####-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
            </td>
            </tr>
            <tr>
                <td>
                    Phone</td>
                <td>
                    <telerik:RadMaskedTextBox ID="BillPhoneTB" Runat="server" 
                        Mask="(###) ###-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                        ControlToValidate="BillPhoneTB" Display="Dynamic" 
                        ErrorMessage="Billing Phone Required" ToolTip="Billing Phone Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Fax</td>
                <td>
                    <telerik:RadMaskedTextBox ID="BillFaxTB" Runat="server" 
                        Mask="(###) ###-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            </table>
    </div>
    <div style="float: left; width: auto;">

    <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label1" runat="server" Text="Shipping Information" 
                        Style="font-weight: bold; font-size: large;"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    First Name:
                </td>
                <td>
                    <telerik:RadTextBox ID="ShipFNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                        ControlToValidate="ShipFNTB" Display="Dynamic" 
                        ErrorMessage="Shipping First Name Required" 
                        ToolTip="Shipping First Name Required">*</asp:RequiredFieldValidator>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Last Name:</td>
                <td>
                    <telerik:RadTextBox ID="ShipLNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                        ControlToValidate="ShipLNTB" ErrorMessage="Shipping Last Name Required" 
                        ToolTip="Shipping Last Name Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Middle Name:</td>
                <td>
                    <telerik:RadTextBox ID="ShipMNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Nick Name:</td>
                <td>
                    <telerik:RadTextBox ID="ShipNNTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Prefix:</td>
                <td>
                    <telerik:RadComboBox ID="ShipPrefixCombo" Runat="server" Skin="Vista">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Selected="True" Text="[Select One]" 
                                Value="[Select One]" />
                            <telerik:RadComboBoxItem runat="server" Text="Mr." Value="Mr." />
                            <telerik:RadComboBoxItem runat="server" Text="Ms." Value="Ms." />
                            <telerik:RadComboBoxItem runat="server" Text="Mrs." Value="Mrs." />
                        </Items>
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    Address:
                </td>
                <td>
                    <telerik:RadTextBox ID="ShipADTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                        ControlToValidate="ShipADTB" Display="Dynamic" 
                        ErrorMessage="Shipping Address Required" 
                        ToolTip="Shipping Address Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Address 2 (Apt, PO Box, etc.)</td>
                <td>
                    <telerik:RadTextBox ID="ShipAD2TB" Runat="server" Width="125px" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    City
                </td>
                <td>
                    <telerik:RadTextBox ID="ShipCityTB" Runat="server" Skin="Vista">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" 
                        ControlToValidate="ShipCityTB" Display="Dynamic" 
                        ErrorMessage="Shipping City Required" ToolTip="Shipping City Required">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Country</td>
                <td>
                <telerik:RadComboBox ID="ShipCountryDropDown" Skin="Vista" Runat="server" 
                        MarkFirstMatch="True">
        <Items>
                                            <telerik:RadComboBoxItem Text="AFGHANISTAN" Value="AFGHANISTAN" />
                                            <telerik:RadComboBoxItem Text="ÅLAND ISLANDS" Value="ÅLAND ISLANDS" />
                                            <telerik:RadComboBoxItem Text="ALBANIA" Value="ALBANIA" />
                                            <telerik:RadComboBoxItem Text="ALGERIA" Value="ALGERIA" />
                                            <telerik:RadComboBoxItem Text="AMERICAN SAMOA" Value="AMERICAN SAMOA" />
                                            <telerik:RadComboBoxItem Text="ANDORRA" Value="ANDORRA" />
                                            <telerik:RadComboBoxItem Text="ANGOLA" Value="ANGOLA" />
                                            <telerik:RadComboBoxItem Text="ANGUILLA" Value="ANGUILLA" />
                                            <telerik:RadComboBoxItem Text="ANTARCTICA" Value="ANTARCTICA" />
                                            <telerik:RadComboBoxItem Text="ANTIGUA AND BARBUDA" 
                                                Value="ANTIGUA AND BARBUDA" />
                                            <telerik:RadComboBoxItem Text="ARGENTINA" Value="ARGENTINA" />
                                            <telerik:RadComboBoxItem Text="ARMENIA" Value="ARMENIA" />
                                            <telerik:RadComboBoxItem Text="ARUBA" Value="ARUBA" />
                                            <telerik:RadComboBoxItem Text="AUSTRALIA" Value="AUSTRALIA" />
                                            <telerik:RadComboBoxItem Text="AUSTRIA" Value="AUSTRIA" />
                                            <telerik:RadComboBoxItem Text="AZERBAIJAN" Value="AZERBAIJAN" />
                                            <telerik:RadComboBoxItem Text="BAHAMAS" Value="BAHAMAS" />
                                            <telerik:RadComboBoxItem Text="BAHRAIN" Value="BAHRAIN" />
                                            <telerik:RadComboBoxItem Text="BANGLADESH" Value="BANGLADESH" />
                                            <telerik:RadComboBoxItem Text="BARBADOS" Value="BARBADOS" />
                                            <telerik:RadComboBoxItem Text="BELARUS" Value="BELARUS" />
                                            <telerik:RadComboBoxItem Text="BELGIUM" Value="BELGIUM" />
                                            <telerik:RadComboBoxItem Text="BELIZE" Value="BELIZE" />
                                            <telerik:RadComboBoxItem Text="BENIN" Value="BENIN" />
                                            <telerik:RadComboBoxItem Text="BERMUDA" Value="BERMUDA" />
                                            <telerik:RadComboBoxItem Text="BHUTAN" Value="BHUTAN" />
                                            <telerik:RadComboBoxItem Text="BOLIVIA" Value="BOLIVIA" />
                                            <telerik:RadComboBoxItem Text="BOSNIA AND HERZEGOVINA" 
                                                Value="BOSNIA AND HERZEGOVINA" />
                                            <telerik:RadComboBoxItem Text="BOTSWANA" Value="BOTSWANA" />
                                            <telerik:RadComboBoxItem Text="BOUVET ISLAND" Value="BOUVET ISLAND" />
                                            <telerik:RadComboBoxItem Text="BRAZIL" Value="BRAZIL" />
                                            <telerik:RadComboBoxItem Text="BRITISH INDIAN OCEAN TERRITORY" 
                                                Value="BRITISH INDIAN OCEAN TERRITORY" />
                                            <telerik:RadComboBoxItem Text="BRUNEI DARUSSALAM" Value="BRUNEI DARUSSALAM" />
                                            <telerik:RadComboBoxItem Text="BULGARIA" Value="BULGARIA" />
                                            <telerik:RadComboBoxItem Text="BURKINA FASO" Value="BURKINA FASO" />
                                            <telerik:RadComboBoxItem Text="BURUNDI" Value="BURUNDI" />
                                            <telerik:RadComboBoxItem Text="CAMBODIA" Value="CAMBODIA" />
                                            <telerik:RadComboBoxItem Text="CAMEROON" Value="CAMEROON" />
                                            <telerik:RadComboBoxItem Text="CANADA" Value="CANADA" />
                                            <telerik:RadComboBoxItem Text="CAPE VERDE" Value="CAPE VERDE" />
                                            <telerik:RadComboBoxItem Text="CAYMAN ISLANDS" Value="CAYMAN ISLANDS" />
                                            <telerik:RadComboBoxItem Text="CENTRAL AFRICAN REPUBLIC" 
                                                Value="CENTRAL AFRICAN REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="CHAD" Value="CHAD" />
                                            <telerik:RadComboBoxItem Text="CHILE" Value="CHILE" />
                                            <telerik:RadComboBoxItem Text="CHINA" Value="CHINA" />
                                            <telerik:RadComboBoxItem Text="CHRISTMAS ISLAND" Value="CHRISTMAS ISLAND" />
                                            <telerik:RadComboBoxItem Text="COCOS (KEELING) ISLANDS" 
                                                Value="COCOS (KEELING) ISLANDS" />
                                            <telerik:RadComboBoxItem Text="COLOMBIA" Value="COLOMBIA" />
                                            <telerik:RadComboBoxItem Text="COMOROS" Value="COMOROS" />
                                            <telerik:RadComboBoxItem Text="CONGO" Value="CONGO" />
                                            <telerik:RadComboBoxItem Text="CONGO, THE DEMOCRATIC REPUBLIC OF THE" 
                                                Value="CONGO" />
                                            <telerik:RadComboBoxItem Text="COOK ISLANDS" Value="COOK ISLANDS" />
                                            <telerik:RadComboBoxItem Text="COSTA RICA" Value="COSTA RICA" />
                                            <telerik:RadComboBoxItem Text="CÔTE D'IVOIRE" Value="CÔTE D'IVOIRE" />
                                            <telerik:RadComboBoxItem Text="CROATIA" Value="CROATIA" />
                                            <telerik:RadComboBoxItem Text="CUBA" Value="CUBA" />
                                            <telerik:RadComboBoxItem Text="CYPRUS" Value="CYPRUS" />
                                            <telerik:RadComboBoxItem Text="CZECH REPUBLIC" Value="CZECH REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="DENMARK" Value="DENMARK" />
                                            <telerik:RadComboBoxItem Text="DJIBOUTI" Value="DJIBOUTI" />
                                            <telerik:RadComboBoxItem Text="DOMINICA" Value="DOMINICA" />
                                            <telerik:RadComboBoxItem Text="DOMINICAN REPUBLIC" Value="DOMINICAN REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="ECUADOR" Value="ECUADOR" />
                                            <telerik:RadComboBoxItem Text="EGYPT" Value="EGYPT" />
                                            <telerik:RadComboBoxItem Text="EL SALVADOR" Value="EL SALVADOR" />
                                            <telerik:RadComboBoxItem Text="EQUATORIAL GUINEA" Value="EQUATORIAL GUINEA" />
                                            <telerik:RadComboBoxItem Text="ERITREA" Value="ERITREA" />
                                            <telerik:RadComboBoxItem Text="ESTONIA" Value="ESTONIA" />
                                            <telerik:RadComboBoxItem Text="ETHIOPIA" Value="ETHIOPIA" />
                                            <telerik:RadComboBoxItem Text="FALKLAND ISLANDS (MALVINAS)" 
                                                Value="FALKLAND ISLANDS (MALVINAS)" />
                                            <telerik:RadComboBoxItem Text="FAROE ISLANDS" Value="FAROE ISLANDS" />
                                            <telerik:RadComboBoxItem Text="FIJI" Value="FIJI" />
                                            <telerik:RadComboBoxItem Text="FINLAND" Value="FINLAND" />
                                            <telerik:RadComboBoxItem Text="FRANCE" Value="FRANCE" />
                                            <telerik:RadComboBoxItem Text="FRENCH GUIANA" Value="FRENCH GUIANA" />
                                            <telerik:RadComboBoxItem Text="FRENCH POLYNESIA" Value="FRENCH POLYNESIA" />
                                            <telerik:RadComboBoxItem Text="FRENCH SOUTHERN TERRITORIES" 
                                                Value="FRENCH SOUTHERN TERRITORIES" />
                                            <telerik:RadComboBoxItem Text="GABON" Value="GABON" />
                                            <telerik:RadComboBoxItem Text="GAMBIA" Value="GAMBIA" />
                                            <telerik:RadComboBoxItem Text="GEORGIA" Value="GEORGIA" />
                                            <telerik:RadComboBoxItem Text="GERMANY" Value="GERMANY" />
                                            <telerik:RadComboBoxItem Text="GHANA" Value="GHANA" />
                                            <telerik:RadComboBoxItem Text="GIBRALTAR" Value="GIBRALTAR" />
                                            <telerik:RadComboBoxItem Text="GREECE" Value="GREECE" />
                                            <telerik:RadComboBoxItem Text="GREENLAND" Value="GREENLAND" />
                                            <telerik:RadComboBoxItem Text="GRENADA" Value="GRENADA" />
                                            <telerik:RadComboBoxItem Text="GUADELOUPE" Value="GUADELOUPE" />
                                            <telerik:RadComboBoxItem Text="GUAM" Value="GUAM" />
                                            <telerik:RadComboBoxItem Text="GUATEMALA" Value="GUATEMALA" />
                                            <telerik:RadComboBoxItem Text="GUERNSEY" Value="GUERNSEY" />
                                            <telerik:RadComboBoxItem Text="GUINEA" Value="GUINEA" />
                                            <telerik:RadComboBoxItem Text="GUINEA-BISSAU" Value="GUINEA-BISSAU" />
                                            <telerik:RadComboBoxItem Text="GUYANA" Value="GUYANA" />
                                            <telerik:RadComboBoxItem Text="HAITI" Value="HAITI" />
                                            <telerik:RadComboBoxItem Text="HEARD ISLAND AND MCDONALD ISLANDS" 
                                                Value="HEARD ISLAND AND MCDONALD ISLANDS" />
                                            <telerik:RadComboBoxItem Text="HOLY SEE (VATICAN CITY STATE)" 
                                                Value="HOLY SEE (VATICAN CITY STATE)" />
                                            <telerik:RadComboBoxItem Text="HONDURAS" Value="HONDURAS" />
                                            <telerik:RadComboBoxItem Text="HONG KONG" Value="HONG KONG" />
                                            <telerik:RadComboBoxItem Text="HUNGARY" Value="HUNGARY" />
                                            <telerik:RadComboBoxItem Text="ICELAND" Value="ICELAND" />
                                            <telerik:RadComboBoxItem Text="INDIA" Value="INDIA" />
                                            <telerik:RadComboBoxItem Text="INDONESIA" Value="INDONESIA" />
                                            <telerik:RadComboBoxItem Text="IRAN, ISLAMIC REPUBLIC OF" Value="IRAN" />
                                            <telerik:RadComboBoxItem Text="IRAQ" Value="IRAQ" />
                                            <telerik:RadComboBoxItem Text="IRELAND" Value="IRELAND" />
                                            <telerik:RadComboBoxItem Text="ISLE OF MAN" Value="ISLE OF MAN" />
                                            <telerik:RadComboBoxItem Text="ISRAEL" Value="ISRAEL" />
                                            <telerik:RadComboBoxItem Text="ITALY" Value="ITALY" />
                                            <telerik:RadComboBoxItem Text="JAMAICA" Value="JAMAICA" />
                                            <telerik:RadComboBoxItem Text="JAPAN" Value="JAPAN" />
                                            <telerik:RadComboBoxItem Text="JERSEY" Value="JERSEY" />
                                            <telerik:RadComboBoxItem Text="JORDAN" Value="JORDAN" />
                                            <telerik:RadComboBoxItem Text="KAZAKHSTAN" Value="KAZAKHSTAN" />
                                            <telerik:RadComboBoxItem Text="KENYA" Value="KENYA" />
                                            <telerik:RadComboBoxItem Text="KIRIBATI" Value="KIRIBATI" />
                                            <telerik:RadComboBoxItem Text="KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF" 
                                                Value="KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="KOREA, REPUBLIC OF" Value="KOREA, REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="KUWAIT" Value="KUWAIT" />
                                            <telerik:RadComboBoxItem Text="KYRGYZSTAN" Value="KYRGYZSTAN" />
                                            <telerik:RadComboBoxItem Text="LAO PEOPLE'S DEMOCRATIC REPUBLIC" 
                                                Value="LAO PEOPLE'S DEMOCRATIC REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="LATVIA" Value="LATVIA" />
                                            <telerik:RadComboBoxItem Text="LEBANON" Value="LEBANON" />
                                            <telerik:RadComboBoxItem Text="LESOTHO" Value="LESOTHO" />
                                            <telerik:RadComboBoxItem Text="LIBERIA" Value="LIBERIA" />
                                            <telerik:RadComboBoxItem Text="LIBYAN ARAB JAMAHIRIYA" 
                                                Value="LIBYAN ARAB JAMAHIRIYA" />
                                            <telerik:RadComboBoxItem Text="LIECHTENSTEIN" Value="LIECHTENSTEIN" />
                                            <telerik:RadComboBoxItem Text="LITHUANIA" Value="LITHUANIA" />
                                            <telerik:RadComboBoxItem Text="LUXEMBOURG" Value="LUXEMBOURG" />
                                            <telerik:RadComboBoxItem Text="MACAO" Value="MACAO" />
                                            <telerik:RadComboBoxItem Text="MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF" 
                                                Value="MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="MADAGASCAR" Value="MADAGASCAR" />
                                            <telerik:RadComboBoxItem Text="MALAWI" Value="MALAWI" />
                                            <telerik:RadComboBoxItem Text="MALAYSIA" Value="MALAYSIA" />
                                            <telerik:RadComboBoxItem Text="MALDIVES" Value="MALDIVES" />
                                            <telerik:RadComboBoxItem Text="MALI" Value="MALI" />
                                            <telerik:RadComboBoxItem Text="MALTA" Value="MALTA" />
                                            <telerik:RadComboBoxItem Text="MARSHALL ISLANDS" Value="MARSHALL ISLANDS" />
                                            <telerik:RadComboBoxItem Text="MARTINIQUE" Value="MARTINIQUE" />
                                            <telerik:RadComboBoxItem Text="MAURITANIA" Value="MAURITANIA" />
                                            <telerik:RadComboBoxItem Text="MAURITIUS" Value="MAURITIUS" />
                                            <telerik:RadComboBoxItem Text="MAYOTTE" Value="MAYOTTE" />
                                            <telerik:RadComboBoxItem Text="MEXICO" Value="MEXICO" />
                                            <telerik:RadComboBoxItem Text="MICRONESIA, FEDERATED STATES OF" 
                                                Value="MICRONESIA, FEDERATED STATES OF" />
                                            <telerik:RadComboBoxItem Text="MOLDOVA, REPUBLIC OF" 
                                                Value="MOLDOVA, REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="MONACO" Value="MONACO" />
                                            <telerik:RadComboBoxItem Text="MONGOLIA" Value="MONGOLIA" />
                                            <telerik:RadComboBoxItem Text="MONTENEGRO" Value="MONTENEGRO" />
                                            <telerik:RadComboBoxItem Text="MONTSERRAT" Value="MONTSERRAT" />
                                            <telerik:RadComboBoxItem Text="MOROCCO" Value="MOROCCO" />
                                            <telerik:RadComboBoxItem Text="MOZAMBIQUE" Value="MOZAMBIQUE" />
                                            <telerik:RadComboBoxItem Text="MYANMAR" Value="MYANMAR" />
                                            <telerik:RadComboBoxItem Text="NAMIBIA" Value="NAMIBIA" />
                                            <telerik:RadComboBoxItem Text="NAURU" Value="NAURU" />
                                            <telerik:RadComboBoxItem Text="NEPAL" Value="NEPAL" />
                                            <telerik:RadComboBoxItem Text="NETHERLANDS" Value="NETHERLANDS" />
                                            <telerik:RadComboBoxItem Text="NETHERLANDS ANTILLES" 
                                                Value="NETHERLANDS ANTILLES" />
                                            <telerik:RadComboBoxItem Text="NEW CALEDONIA" Value="NEW CALEDONIA" />
                                            <telerik:RadComboBoxItem Text="NEW ZEALAND" Value="NEW ZEALAND" />
                                            <telerik:RadComboBoxItem Text="NICARAGUA" Value="NICARAGUA" />
                                            <telerik:RadComboBoxItem Text="NIGER" Value="NIGER" />
                                            <telerik:RadComboBoxItem Text="NIGERIA" Value="NIGERIA" />
                                            <telerik:RadComboBoxItem Text="NIUE" Value="NIUE" />
                                            <telerik:RadComboBoxItem Text="NORFOLK ISLAND" Value="NORFOLK ISLAND" />
                                            <telerik:RadComboBoxItem Text="NORTHERN MARIANA ISLANDS" 
                                                Value="NORTHERN MARIANA ISLANDS" />
                                            <telerik:RadComboBoxItem Text="NORWAY" Value="NORWAY" />
                                            <telerik:RadComboBoxItem Text="OMAN" Value="OMAN" />
                                            <telerik:RadComboBoxItem Text="PAKISTAN" Value="PAKISTAN" />
                                            <telerik:RadComboBoxItem Text="PALAU" Value="PALAU" />
                                            <telerik:RadComboBoxItem Text="PALESTINIAN TERRITORY, OCCUPIED" 
                                                Value="PALESTINIAN TERRITORY, OCCUPIED" />
                                            <telerik:RadComboBoxItem Text="PANAMA" Value="PANAMA" />
                                            <telerik:RadComboBoxItem Text="PAPUA NEW GUINEA" Value="PAPUA NEW GUINEA" />
                                            <telerik:RadComboBoxItem Text="PARAGUAY" Value="PARAGUAY" />
                                            <telerik:RadComboBoxItem Text="PERU" Value="PERU" />
                                            <telerik:RadComboBoxItem Text="PHILIPPINES" Value="PHILIPPINES" />
                                            <telerik:RadComboBoxItem Text="PITCAIRN" Value="PITCAIRN" />
                                            <telerik:RadComboBoxItem Text="POLAND" Value="POLAND" />
                                            <telerik:RadComboBoxItem Text="PORTUGAL" Value="PORTUGAL" />
                                            <telerik:RadComboBoxItem Text="PUERTO RICO" Value="PUERTO RICO" />
                                            <telerik:RadComboBoxItem Text="QATAR" Value="QATAR" />
                                            <telerik:RadComboBoxItem Text="RÉUNION" Value="RÉUNION" />
                                            <telerik:RadComboBoxItem Text="ROMANIA" Value="ROMANIA" />
                                            <telerik:RadComboBoxItem Text="RUSSIAN FEDERATION" Value="RUSSIAN FEDERATION" />
                                            <telerik:RadComboBoxItem Text="RWANDA" Value="RWANDA" />
                                            <telerik:RadComboBoxItem Text="SAINT BARTHÉLEMY" Value="SAINT BARTHÉLEMY" />
                                            <telerik:RadComboBoxItem Text="SAINT HELENA" Value="SAINT HELENA" />
                                            <telerik:RadComboBoxItem Text="SAINT KITTS AND NEVIS" 
                                                Value="SAINT KITTS AND NEVIS" />
                                            <telerik:RadComboBoxItem Text="SAINT LUCIA" Value="SAINT LUCIA" />
                                            <telerik:RadComboBoxItem Text="SAINT MARTIN" Value="SAINT MARTIN" />
                                            <telerik:RadComboBoxItem Text="SAINT PIERRE AND MIQUELON" 
                                                Value="SAINT PIERRE AND MIQUELON" />
                                            <telerik:RadComboBoxItem Text="SAINT VINCENT AND THE GRENADINES" 
                                                Value="SAINT VINCENT AND THE GRENADINES" />
                                            <telerik:RadComboBoxItem Text="SAMOA" Value="SAMOA" />
                                            <telerik:RadComboBoxItem Text="SAN MARINO" Value="SAN MARINO" />
                                            <telerik:RadComboBoxItem Text="SAO TOME AND PRINCIPE" 
                                                Value="SAO TOME AND PRINCIPE" />
                                            <telerik:RadComboBoxItem Text="SAUDI ARABIA" Value="SAUDI ARABIA" />
                                            <telerik:RadComboBoxItem Text="SENEGAL" Value="SENEGAL" />
                                            <telerik:RadComboBoxItem Text="SERBIA" Value="SERBIA" />
                                            <telerik:RadComboBoxItem Text="SEYCHELLES" Value="SEYCHELLES" />
                                            <telerik:RadComboBoxItem Text="SIERRA LEONE" Value="SIERRA LEONE" />
                                            <telerik:RadComboBoxItem Text="SINGAPORE" Value="SINGAPORE" />
                                            <telerik:RadComboBoxItem Text="SLOVAKIA" Value="SLOVAKIA" />
                                            <telerik:RadComboBoxItem Text="SLOVENIA" Value="SLOVENIA" />
                                            <telerik:RadComboBoxItem Text="SOLOMON ISLANDS" Value="SOLOMON ISLANDS" />
                                            <telerik:RadComboBoxItem Text="SOMALIA" Value="SOMALIA" />
                                            <telerik:RadComboBoxItem Text="SOUTH AFRICA" Value="SOUTH AFRICA" />
                                            <telerik:RadComboBoxItem Text="SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS" 
                                                Value="SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS" />
                                            <telerik:RadComboBoxItem Text="SPAIN" Value="SPAIN" />
                                            <telerik:RadComboBoxItem Text="SRI LANKA" Value="SRI LANKA" />
                                            <telerik:RadComboBoxItem Text="SUDAN" Value="SUDAN" />
                                            <telerik:RadComboBoxItem Text="SURINAME" Value="SURINAME" />
                                            <telerik:RadComboBoxItem Text="SVALBARD AND JAN MAYEN" 
                                                Value="SVALBARD AND JAN MAYEN" />
                                            <telerik:RadComboBoxItem Text="SWAZILAND" Value="SWAZILAND" />
                                            <telerik:RadComboBoxItem Text="SWEDEN" Value="SWEDEN" />
                                            <telerik:RadComboBoxItem Text="SWITZERLAND" Value="SWITZERLAND" />
                                            <telerik:RadComboBoxItem Text="SYRIAN ARAB REPUBLIC" 
                                                Value="SYRIAN ARAB REPUBLIC" />
                                            <telerik:RadComboBoxItem Text="TAIWAN, PROVINCE OF CHINA" 
                                                Value="TAIWAN, PROVINCE OF CHINA" />
                                            <telerik:RadComboBoxItem Text="TAJIKISTAN" Value="TAJIKISTAN" />
                                            <telerik:RadComboBoxItem Text="TANZANIA, UNITED REPUBLIC OF" 
                                                Value="TANZANIA, UNITED REPUBLIC OF" />
                                            <telerik:RadComboBoxItem Text="THAILAND" Value="THAILAND" />
                                            <telerik:RadComboBoxItem Text="TIMOR-LESTE" Value="TIMOR-LESTE" />
                                            <telerik:RadComboBoxItem Text="TOGO" Value="TOGO" />
                                            <telerik:RadComboBoxItem Text="TOKELAU" Value="TOKELAU" />
                                            <telerik:RadComboBoxItem Text="TONGA" Value="TONGA" />
                                            <telerik:RadComboBoxItem Text="TRINIDAD AND TOBAGO" 
                                                Value="TRINIDAD AND TOBAGO" />
                                            <telerik:RadComboBoxItem Text="TUNISIA" Value="TUNISIA" />
                                            <telerik:RadComboBoxItem Text="TURKEY" Value="TURKEY" />
                                            <telerik:RadComboBoxItem Text="TURKMENISTAN" Value="TURKMENISTAN" />
                                            <telerik:RadComboBoxItem Text="TURKS AND CAICOS ISLANDS" 
                                                Value="TURKS AND CAICOS ISLANDS" />
                                            <telerik:RadComboBoxItem Text="TUVALU" Value="TUVALU" />
                                            <telerik:RadComboBoxItem Text="UGANDA" Value="UGANDA" />
                                            <telerik:RadComboBoxItem Text="UKRAINE" Value="UKRAINE" />
                                            <telerik:RadComboBoxItem Text="UNITED ARAB EMIRATES" 
                                                Value="UNITED ARAB EMIRATES" />
                                            <telerik:RadComboBoxItem Text="UNITED KINGDOM" Value="UNITED KINGDOM" />
                                            <telerik:RadComboBoxItem Text="UNITED STATES" Value="USA" Selected="True" />
                                            <telerik:RadComboBoxItem Text="UNITED STATES MINOR OUTLYING ISLANDS" 
                                                Value="UNITED STATES MINOR OUTLYING ISLANDS" />
                                            <telerik:RadComboBoxItem Text="URUGUAY" Value="URUGUAY" />
                                            <telerik:RadComboBoxItem Text="UZBEKISTAN" Value="UZBEKISTAN" />
                                            <telerik:RadComboBoxItem Text="VANUATU" Value="VANUATU" />
                                            <telerik:RadComboBoxItem Text="VATICAN CITY STATE" Value="VATICAN CITY STATE" />
                                            <telerik:RadComboBoxItem Text="VENEZUELA" Value="VENEZUELA" />
                                            <telerik:RadComboBoxItem Text="VIET NAM" Value="VIET NAM" />
                                            <telerik:RadComboBoxItem Text="VIRGIN ISLANDS, BRITISH" 
                                                Value="VIRGIN ISLANDS, BRITISH" />
                                            <telerik:RadComboBoxItem Text="VIRGIN ISLANDS, U.S." 
                                                Value="VIRGIN ISLANDS, U.S." />
                                            <telerik:RadComboBoxItem Text="WALLIS AND FUTUNA" Value="WALLIS AND FUTUNA" />
                                            <telerik:RadComboBoxItem Text="WESTERN SAHARA" Value="WESTERN SAHARA" />
                                            <telerik:RadComboBoxItem Text="YEMEN" Value="YEMEN" />
                                            <telerik:RadComboBoxItem Text="ZAIRE, THE DEMOCRATIC REPUBLIC OF THE" 
                                                Value="ZAIRE, THE DEMOCRATIC REPUBLIC OF THE" />
                                            <telerik:RadComboBoxItem Text="ZAMBIA" Value="ZAMBIA" />
                                            <telerik:RadComboBoxItem Text="ZIMBABWE" Value="ZIMBABWE" />
        </Items>

<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
        </telerik:RadComboBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    State (U.S. only)</td>
                <td>
    <telerik:RadComboBox ID="ShipStateDropDown" Skin="Vista" Runat="server" 
                        MarkFirstMatch="True">
        <Items>
                                            <telerik:RadComboBoxItem Text="-- Select state --" Value="" />
                                            <telerik:RadComboBoxItem Text="Alabama" Value="AL" />
                                            <telerik:RadComboBoxItem Text="Alaska" Value="AK" />
                                            <telerik:RadComboBoxItem Text="Arizona" Value="AZ" />
                                            <telerik:RadComboBoxItem Text="Arkansas" Value="AR" />
                                            <telerik:RadComboBoxItem Text="California" Value="CA" />
                                            <telerik:RadComboBoxItem Text="Colorado" Value="CO" />
                                            <telerik:RadComboBoxItem Text="Connecticut" Value="CT" />
                                            <telerik:RadComboBoxItem Text="Delaware" Value="DE" />
                                            <telerik:RadComboBoxItem Text="District of Columbia" Value="DC" />
                                            <telerik:RadComboBoxItem Text="Florida" Value="FL" />
                                            <telerik:RadComboBoxItem Text="Georgia" Value="GA" />
                                            <telerik:RadComboBoxItem Text="Hawaii" Value="HA" />
                                            <telerik:RadComboBoxItem Text="Idaho" Value="ID" />
                                            <telerik:RadComboBoxItem Text="Illinois" Value="IL" />
                                            <telerik:RadComboBoxItem Text="Indiana" Value="IN" />
                                            <telerik:RadComboBoxItem Text="Iowa" Value="IO" />
                                            <telerik:RadComboBoxItem Text="Kansas" Value="KS" />
                                            <telerik:RadComboBoxItem Text="Kentucky" Value="KY" />
                                            <telerik:RadComboBoxItem Text="Louisiana" Value="LA" />
                                            <telerik:RadComboBoxItem Text="Maine" Value="ME" />
                                            <telerik:RadComboBoxItem Text="Maryland" Value="MD" />
                                            <telerik:RadComboBoxItem Text="Massachusetts" Value="MA" />
                                            <telerik:RadComboBoxItem Text="Michigan" Value="MI" />
                                            <telerik:RadComboBoxItem Text="Minnesota" Value="MN" />
                                            <telerik:RadComboBoxItem Text="Mississippi" Value="MS" />
                                            <telerik:RadComboBoxItem Text="Missouri" Value="MO" />
                                            <telerik:RadComboBoxItem Text="Montana" Value="MT" />
                                            <telerik:RadComboBoxItem Text="Nebraska" Value="NE" />
                                            <telerik:RadComboBoxItem Text="Nevada" Value="NV" />
                                            <telerik:RadComboBoxItem Text="New Hampshire" Value="NH" />
                                            <telerik:RadComboBoxItem Text="New Jersey" Value="NJ" />
                                            <telerik:RadComboBoxItem Text="New Mexico" Value="NM" />
                                            <telerik:RadComboBoxItem Text="New York" Value="NY" />
                                            <telerik:RadComboBoxItem Text="North Carolina" Value="NC" />
                                            <telerik:RadComboBoxItem Text="North Dakota" Value="ND" />
                                            <telerik:RadComboBoxItem Text="Ohio" Value="OH" />
                                            <telerik:RadComboBoxItem Text="Oklahoma" Value="OK" />
                                            <telerik:RadComboBoxItem Text="Oregon" Value="OR" />
                                            <telerik:RadComboBoxItem Text="Pennsylvania" Value="PA" />
                                            <telerik:RadComboBoxItem Text="Rhode Island" Value="RI" />
                                            <telerik:RadComboBoxItem Text="South Carolina" Value="SC" />
                                            <telerik:RadComboBoxItem Text="South Dakota" Value="SD" />
                                            <telerik:RadComboBoxItem Text="Tennessee" Value="TN" />
                                            <telerik:RadComboBoxItem Text="Texas" Value="TX" />
                                            <telerik:RadComboBoxItem Text="Utah" Value="UT" />
                                            <telerik:RadComboBoxItem Text="Vermont" Value="VT" />
                                            <telerik:RadComboBoxItem Text="Virginia" Value="VA" />
                                            <telerik:RadComboBoxItem Text="Washington" Value="WA" />
                                            <telerik:RadComboBoxItem Text="West Virginia" Value="WV" />
                                            <telerik:RadComboBoxItem Text="Wisconsin" Value="WI" />
                                            <telerik:RadComboBoxItem Text="Wyoming" Value="WY" />
          
        </Items>
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
    </telerik:RadComboBox>
                    </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
            <td>
            Zip Code
            </td>
            <td>
            <telerik:RadMaskedTextBox ID="ShipZipCodeTB" Runat="server" 
                        Mask="#####-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
            </td>
            </tr>
            <tr>
                <td>
                    Phone</td>
                <td>
                    <telerik:RadMaskedTextBox ID="ShipPhoneTB" Runat="server" 
                        Mask="(###) ###-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                        ControlToValidate="ShipPhoneTB" Display="Dynamic" 
                        ErrorMessage="Shipping Phone Required" ToolTip="Shipping Phone Required">*</asp:RequiredFieldValidator>
                        </td>
            </tr>
            <tr>
                <td>
                    Fax</td>
                <td>
                    <telerik:RadMaskedTextBox ID="ShipFaxTB" Runat="server" 
                        Mask="(###) ###-####" Skin="Vista">
                    </telerik:RadMaskedTextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            </table>
            
           
    </div>
    <telerik:RadFormDecorator ID="RadFormDecorator1" Runat="server" Skin="Vista" />
    <br />
    <div style="clear: both;">
    <asp:CheckBox ID="BillShipCheck" runat="server" 
        Text="Billing and Shipping info are the same" AutoPostBack="True" 
            oncheckedchanged="BillShipCheck_CheckedChanged" />
        <br />
        <br />
     <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
            onclick="btnSubmit_Click" />
     
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" />
        <br />
        <br />
        <asp:Label ID="ErrorLabel" runat="server" ></asp:Label>
        </div>