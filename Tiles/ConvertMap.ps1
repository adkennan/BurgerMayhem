[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $mapPath    
)

$mapName = [io.path]::GetFileNameWithoutExtension($mapPath).ToUpper()

$tiles = @{
    "1" = "TILE_VOID";
    "34" = "TILE_PLATE";
    "67" = "TILE_BUN";
    "100" = "TILE_MEAT";
    "133" = "TILE_TOMATO";
    "166" = "TILE_LETTUCE";
    "199" = "TILE_SERVE";
    "232" = "TILE_BIN";
    "265" = "TILE_STOVE";
    "298" = "TILE_CHOP";
    "331" = "TILE_BENCH";

    "2" = "TILE_SLIDER_N";
    "35" = "TILE_SLIDER_S";
    "68" = "TILE_SLIDER_E";
    "101" = "TILE_SLIDER_W";
    "134" = "TILE_BLOCKER_0";
    "167" = "TILE_BLOCKER_1";
    "200" = "TILE_BLOCKER_2";
    "233" = "TILE_BLOCKER_3";

    # Kitchen
    "3" = "TILE_FLOOR_0";
    "36" = "TILE_FLOOR_1";
    "69" = "TILE_FLOOR_2";
    "102" = "TILE_FLOOR_3";
    "135" = "TILE_WALL_0";
    "168" = "TILE_WALL_1";
    "201" = "TILE_WALL_2";
    "234" = "TILE_WALL_3";

    # Forest
    "4" = "TILE_FLOOR_0";
    "37" = "TILE_FLOOR_1";
    "70" = "TILE_FLOOR_2";
    "103" = "TILE_FLOOR_3";
    "136" = "TILE_WALL_0";
    "169" = "TILE_WALL_1";
    "202" = "TILE_WALL_2";
    "235" = "TILE_WALL_3";

    # Castle
    "5" = "TILE_FLOOR_0";
    "38" = "TILE_FLOOR_1";
    "71" = "TILE_FLOOR_2";
    "104" = "TILE_FLOOR_3";
    "137" = "TILE_WALL_0";
    "170" = "TILE_WALL_1";
    "203" = "TILE_WALL_2";
    "236" = "TILE_WALL_3";

    # Desert
    "6" = "TILE_FLOOR_0";
    "39" = "TILE_FLOOR_1";
    "72" = "TILE_FLOOR_2";
    "105" = "TILE_FLOOR_3";
    "138" = "TILE_WALL_0";
    "171" = "TILE_WALL_1";
    "204" = "TILE_WALL_2";
    "237" = "TILE_WALL_3";

    # Space
    "7" = "TILE_FLOOR_0";
    "40" = "TILE_FLOOR_1";
    "73" = "TILE_FLOOR_2";
    "106" = "TILE_FLOOR_3";
    "139" = "TILE_WALL_0";
    "172" = "TILE_WALL_1";
    "205" = "TILE_WALL_2";
    "238" = "TILE_WALL_3";
}

[xml]$xmlContent = Get-Content $mapPath

$csvContent = (Select-Xml "//map/layer[@name='Tile Layer 1']/data" $xmlContent)[0].Node.'#text' -replace '\s+', ''

$tileKeys = $csvContent -split ','

$mapContent = ""
$ix = 0
foreach( $tk in $tileKeys ) {
    $tileName = $tiles[$tk]
    if( $ix -eq 0 ) {
        $mapContent = "$($mapContent)`tBYTE "
    }
    $mapContent = "$($mapContent)$($tileName),`t"
    $ix++
    if( $ix -eq 13 ) {
        $mapContent = "$($mapContent)`$FF`n"
        $ix = 0
    }
}

$mapContent = "`tBYTE $("TILE_VOID,`t" * 12)`$FF`nMAP_$($mapName)`n$($mapContent)`n`tBYTE $("TILE_VOID,`t" * 12)`$FF`n"

Set-Content -Path "..\Maps\$($mapName).asm" -Value $mapContent