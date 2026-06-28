Add-Type -AssemblyName System.Drawing
$sourceFile = "d:\Users\Downloads\Last Unit\logo (1).png"
$sourceImg = [System.Drawing.Image]::FromFile($sourceFile)

$sizes = @(16, 32, 114, 128, 256, 512)

foreach ($size in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    # Draw a black background since the logo is likely designed for dark themes
    $g.Clear([System.Drawing.Color]::Black)
    
    # Maintain aspect ratio and center
    $ratio = [math]::Min($size / $sourceImg.Width, $size / $sourceImg.Height)
    $newWidth = [int]($sourceImg.Width * $ratio)
    $newHeight = [int]($sourceImg.Height * $ratio)
    
    $x = [int](($size - $newWidth) / 2)
    $y = [int](($size - $newHeight) / 2)
    
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($sourceImg, $x, $y, $newWidth, $newHeight)
    
    $targetFile = "d:\Users\Downloads\Last Unit\icon-$size.png"
    $bmp.Save($targetFile, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $g.Dispose()
    $bmp.Dispose()
}

$sourceImg.Dispose()
