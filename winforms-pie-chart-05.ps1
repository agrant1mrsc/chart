#https://gist.github.com/SoftwareDevWithThomas/0959b0bdd1c8c6fdcf05e78104ab6b62
#https://learn.microsoft.com/en-us/dotnet/standard/base-types/standard-numeric-format-strings
#Reference necessary assemblies to get the chart and form type into the scope
Set-PSDebug -Trace 0

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms.DataVisualization

#wipe variables
Clear-Variable chart,chart_area,series,legend,timer,window,[string]number
#Instantiate the chart types
$chart = New-Object System.Windows.Forms.DataVisualization.Charting.Chart
$chart_area = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
$series = New-Object  System.Windows.Forms.DataVisualization.Charting.Series
$legend = New-Object System.Windows.Forms.DataVisualization.Charting.Legend
$customlabel = new-object System.Windows.Forms.DataVisualization.Charting.CustomLabel

#setup the custom label
# $customlabel.text = 'bob'
# $customlabel.FromPosition = 0
# $customlabel.ToPosition = 1000

#setup chart_area
$chart_area.InnerPlotPosition.height
$chart_area.InnerPlotPosition.width
$chart_area.position.Height
$chart_area.position.width


#Compose the instantiated objects and set the properties
$chart.width = 1044
$chart.height = 996
$chart.Series.Add($series)
$chart.ChartAreas.Add($chart_area)
# $chart.Legends.Add($legend)
$chart.ChartAreas.AxisY.Maximum = 1000
$chart.ChartAreas.AxisX.Maximum = 1000
$chart.ChartAreas.AxisY.minimum = 0
$chart.ChartAreas.AxisX.minimum = 0
$chart.ChartAreas.AxisX.MajorGrid.interval = 100
$chart.ChartAreas.AxisY.MajorGrid.interval = 100
$series.ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::point

# $chart.ChartAreas.AxisY.LabelStyle.Format = 'D'
# $chart.ChartAreas.AxisX.LabelStyle.Format = 'D'
# $chart.ChartAreas.axisx.CustomLabels.Add($customlabel)
# $chart.Dock = [System.Windows.Forms.DockStyle]::Fill


1..1000000 | % {
    [string]$number = get-random 999999
    [int]$x = [string]$number.PadLeft(6,'0').Substring(0,3)
    [int]$y = [string]$number.PadLeft(6,'0').Substring(3,3)
    $series.Points.addXY($x,$y)
   } | out-null



#timer
# $timer = New-Object System.Windows.Forms.Timer
# $timer.Interval = 1000
# $timer.Enabled = 'True'
# $timer.Add_Tick({UpdateChart})`

#Set up the window and add the chart to the window
$window = New-Object System.Windows.Forms.Form
$window.width = 1100
$window.height = 1100
$window.Text = "SHA1 Hash Distribution"
$window.Controls.Add($chart);
#Show the window
$window.BringToFront();
$window.ShowDialog();



# $chart | Get-Member | select-string -InputObject {$_} -pattern 'color'
# #chart calculations

# $cap = $chart_area.Position
# $ipp = $chart_area.InnerPlotPosition
# #chartarea pixel size
# $casize = @(($cap.Width * $chart.ClientSize.width / 100),($cap.height * $chart.ClientSize.Height / 100))
# $ippsize = @(($ipp.width * $casize[0] / 100),($ipp.height * $casize[1] / 100))

