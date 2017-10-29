(* ::Package:: *)


(*

---Scientific Styling---

Made with Mathematica Version:		11.1.1.0
author:								mathe172
Last changed:						29.10.17

Styling Package for Mathematica Plots with a more scientific look
This Package changes the default plotting Settings for all the plot techniques specified below.

Plots categorized in basicPlots, polarPlots, polarPlotsNoJoin, themedPlots and plots3D

TODO: Histograms, Histogram3D, BarChart...
*)


(*------------------------------------------------------------------------------------------------------------------------------
Helper Function
*)
BeginPackage["Styling`"]
niceRadialTicks/:Switch[niceRadialTicks,a___]:=Switch[Automatic,a]/.l:{__Text}:>Most@l
niceRadialTicks/:MemberQ[a___,niceRadialTicks]:=MemberQ[a,Automatic]


(*------------------------------------------------------------------------------------------------------------------------------
StylePlots Function (=main)
*)
StylePlots[OptionsPattern[]]:=
Module[
{
fontStyle=Directive[Black,FontSize->OptionValue[FontSize],FontFamily->"Times"],
smallFontStyle=Directive[Black,FontSize->0.9OptionValue[FontSize],FontFamily->"Times"]
},


(*-----------------------------------------------------------------------------------------------------------------------------
Categories for Plots
*)
basicPlots={ListContourPlot};
polarPlots={ListPolarPlot};
polarPlotsNoJoin={PolarPlot};
themedPlots={LogLogPlot,ListLogLogPlot,ListLogPlot,ListLinePlot,ListPlot,Plot,ParametricPlot,SmoothHistogram}~Join~polarPlots;
plots3D={ListPlot3D,ListPointPlot3D,ParametricPlot3D};
histogramType={Histograms,BarChart,PieChart};

(*-----------------------------------------------------------------------------------------------------------------------------
Set Options
*)
SetOptions[basicPlots~Join~themedPlots,LabelStyle->fontStyle,FrameStyle->fontStyle,FrameTicksStyle->smallFontStyle,Frame->True,PlotRangePadding->0,Axes->False];
SetOptions[plots3D,LabelStyle->fontStyle,PlotRangePadding->0];
SetOptions[themedPlots~Join~plots3D,PlotTheme->"VibrantColors"];
SetOptions[polarPlots,Joined->True,Mesh->All,PolarGridLines->Automatic,PolarTicks->{"Degrees",niceRadialTicks},TicksStyle->smallFontStyle,Frame->False,PolarAxes->True,PlotRangePadding->Scaled[0.1]];
SetOptions[polarPlotsNoJoin,Mesh->All,PolarGridLines->Automatic,PolarTicks->{"Degrees",niceRadialTicks},TicksStyle->smallFontStyle,Frame->False,PolarAxes->True,PlotRangePadding->Scaled[0.1]];
]
Options[StylePlots]={FontSize->15};

ResetStyle[]:=(krnl=LaunchKernels@1;
SetOptions@@Join[{#},ParallelEvaluate[Options[#],krnl]]&/@Flatten@{basicPlots,themedPlots,plots3D};
CloseKernels[krnl];)

jet::usage="magic colors from http://stackoverflow.com/questions/5753508/custom-colorfunction-colordata-in-arrayplot-and-similar-functions/9321152#9321152"
jet[u_?NumericQ]:=Blend[{{0,RGBColor[0,0,9/16]},{1/9,Blue},{23/63,Cyan},{13/21,Yellow},{47/63,Orange},{55/63,Red},{1,RGBColor[1/2,0,0]}},u]/;0<=u<=1
EndPackage[]



