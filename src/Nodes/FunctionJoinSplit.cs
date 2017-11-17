#region usings
using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.Composition;

using VVVV.PluginInterfaces.V1;
using VVVV.PluginInterfaces.V2;

using VVVV.DX11;
using VVVV.Utils.Streams;
using VVVV.Nodes.Generic;
using FeralTic.DX11;
using FeralTic.DX11.Resources;


#endregion usings

namespace VVVV.DX11.Node
{
    public class FieldTripFunction
    {
        public string HLSL = "";
        public List<IDX11RenderSemantic> CustomSemantics = new List<IDX11RenderSemantic>();
        public List<DX11Resource<IDX11RenderSemantic>> ResourceSemantics = new List<DX11Resource<IDX11RenderSemantic>>();
     
        public FieldTripFunction() { }

        public void SetString(string hlsl)
        {
            HLSL = hlsl;
        }

        public void SetSemantics(IEnumerable<IDX11RenderSemantic> customSemantics)
        {
            CustomSemantics.AddRange(customSemantics);
        }

        public void SetResources(IEnumerable<DX11Resource<IDX11RenderSemantic>> resourceSemantics)
        {
            ResourceSemantics.AddRange(resourceSemantics);
        }
 
    }

    public class SF2D : FieldTripFunction { }
    public class VF2D : FieldTripFunction { }
    public class SF3D : FieldTripFunction { }
    public class VF3D : FieldTripFunction { }

    /*
    #region PluginInfo
    [PluginInfo(Name = "Join", Category = "FieldTripFunction", Help = "Joins hlsl string with semantics", Author = "everyoneishappy", Tags = "")]
    #endregion PluginInfo
    public class FieldTripFunctionJoin : IPluginEvaluate, IDX11ResourceDataRetriever
    {
        #region fields & pins
        [Input("HLSL", IsSingle = true)]
        public IDiffSpread<string> FInHLSL;

        [Input("Custom Semantic")]
        protected Pin<IDX11RenderSemantic> FInCustomSemantic;

        [Input("Resource Semantic")]
        protected Pin<DX11Resource<IDX11RenderSemantic>> FInResourceSemantic;

        [Output("Output", IsSingle = true)]
        public ISpread<FieldTripFunction> FOutFieldTripFunction;


        [Import()]
        protected IPluginHost FHost;

        #endregion fields & pins
        public void Evaluate(int SpreadMax)
        {
            if (this.RenderRequest != null) { RenderRequest(this, this.FHost); }

            if (!(FInHLSL.IsChanged || FInCustomSemantic.IsChanged || FInResourceSemantic.IsChanged)) return;

            FieldTripFunction ftFunc = new FieldTripFunction();

            ftFunc.SetString(FInHLSL[0]);
            if (FInCustomSemantic.IsConnected) ftFunc.SetSemantics(FInCustomSemantic);
            if (FInResourceSemantic.IsConnected) ftFunc.SetResources(FInResourceSemantic);
            FOutFieldTripFunction[0] = ftFunc;
        }

        #region dx11
        public DX11RenderContext AssignedContext
        {
            get;
            set;
        }

        public event DX11RenderRequestDelegate RenderRequest;

        #endregion dx11

    }

    #region PluginInfo
    [PluginInfo(Name = "Split", Category = "FieldTripFunction", Help = "Splits function in to hlsl string and semantics", Author = "everyoneishappy", Tags = "")]
    #endregion PluginInfo
    public class FieldTripFunctionSplit : IPluginEvaluate, IDX11ResourceHost
    {
        #region fields & pins

        [Input("Input", IsSingle = true)]
        public IDiffSpread<FieldTripFunction> FInFieldTripFunction;

        [Input("Enabled", DefaultBoolean = true, IsSingle = true)]
        public ISpread<bool> FEnabled;

        [Output("HLSL", IsSingle = true)]
        public ISpread<string> FHLSL;

        [Output("Custom Semantics")]
        public ISpread<IDX11RenderSemantic> FOutCustomSemantic;

        [Output("Resource Semantics")]
        public ISpread<DX11Resource<IDX11RenderSemantic>> FOutResourceSemantic;

        #endregion fields & pins

        public void Evaluate(int SpreadMax)
        {
            if (!FInFieldTripFunction.IsChanged || !FEnabled[0]) return;
            FOutCustomSemantic.SliceCount = 0;
            FOutResourceSemantic.SliceCount = 0;
            FieldTripFunction ftFunc = FInFieldTripFunction[0];
            if (ftFunc != null)
            {
                FHLSL[0] = ftFunc.HLSL;
               
                if (ftFunc.CustomSemantics.Count > 0)
                {
                    FOutCustomSemantic.AssignFrom(ftFunc.CustomSemantics);
                }

                if (ftFunc.ResourceSemantics.Count > 0)
                {
                    FOutResourceSemantic.AssignFrom(ftFunc.ResourceSemantics);
                }
            }
        }

        public void Update(DX11RenderContext context)
        {

        }

        public void Destroy(DX11RenderContext context, bool force)
        {
            for (int i = 0; i < this.FOutResourceSemantic.SliceCount; i++)
            {
                this.FOutResourceSemantic[i].Dispose(context);
            }
        }
    }
    */

    //These should use generics or something...

    #region PluginInfo
    [PluginInfo(Name = "Join", Category = "SF2D", Help = "Joins hlsl string with semantics", Author = "everyoneishappy", Tags = "Fieldtrip")]
    #endregion PluginInfo
    public class SF2DJoin : IPluginEvaluate, IDX11ResourceDataRetriever
    {
        #region fields & pins
        [Input("HLSL", IsSingle = true)]
        public IDiffSpread<string> FInHLSL;

        [Input("Custom Semantic")]
        protected Pin<IDX11RenderSemantic> FInCustomSemantic;

        [Input("Resource Semantic")]
        protected Pin<DX11Resource<IDX11RenderSemantic>> FInResourceSemantic;

        [Output("Output", IsSingle = true)]
        public ISpread<SF2D> FOutFieldTripFunction;


        [Import()]
        protected IPluginHost FHost;

        #endregion fields & pins
        public void Evaluate(int SpreadMax)
        {
            if (this.RenderRequest != null) { RenderRequest(this, this.FHost); }

            if (!(FInHLSL.IsChanged || FInCustomSemantic.IsChanged || FInResourceSemantic.IsChanged)) return;

            SF2D ftFunc = new SF2D();

            ftFunc.SetString(FInHLSL[0]);
            if (FInCustomSemantic.IsConnected) ftFunc.SetSemantics(FInCustomSemantic);
            if (FInResourceSemantic.IsConnected) ftFunc.SetResources(FInResourceSemantic);
            FOutFieldTripFunction[0] = ftFunc;
        }

        #region dx11
        public DX11RenderContext AssignedContext
        {
            get;
            set;
        }

        public event DX11RenderRequestDelegate RenderRequest;

        #endregion dx11

    }

    #region PluginInfo
    [PluginInfo(Name = "Split", Category = "SF2D", Help = "Splits function in to hlsl string and semantics", Author = "everyoneishappy", Tags = "FieldTrip")]
    #endregion PluginInfo
    public class SF2DSplit : IPluginEvaluate, IDX11ResourceHost
    {
        #region fields & pins

        [Input("Input", IsSingle = true)]
        public IDiffSpread<SF2D> FInFieldTripFunction;

        [Input("Enabled", DefaultBoolean = true, IsSingle = true)]
        public ISpread<bool> FEnabled;

        [Output("HLSL", IsSingle = true)]
        public ISpread<string> FHLSL;

        [Output("Custom Semantics")]
        public ISpread<IDX11RenderSemantic> FOutCustomSemantic;

        [Output("Resource Semantics")]
        public ISpread<DX11Resource<IDX11RenderSemantic>> FOutResourceSemantic;

        #endregion fields & pins

        public void Evaluate(int SpreadMax)
        {
            if (!FInFieldTripFunction.IsChanged || !FEnabled[0]) return;
            FOutCustomSemantic.SliceCount = 0;
            FOutResourceSemantic.SliceCount = 0;
            SF2D ftFunc = FInFieldTripFunction[0];
            if (ftFunc != null)
            {
                FHLSL[0] = ftFunc.HLSL;

                if (ftFunc.CustomSemantics.Count > 0)
                {
                    FOutCustomSemantic.AssignFrom(ftFunc.CustomSemantics);
                }

                if (ftFunc.ResourceSemantics.Count > 0)
                {
                    FOutResourceSemantic.AssignFrom(ftFunc.ResourceSemantics);
                }
            }
        }

        public void Update(DX11RenderContext context)
        {

        }

        public void Destroy(DX11RenderContext context, bool force)
        {
            for (int i = 0; i < this.FOutResourceSemantic.SliceCount; i++)
            {
                this.FOutResourceSemantic[i].Dispose(context);
            }
        }
    }

    #region PluginInfo
    [PluginInfo(Name = "Join", Category = "VF2D", Help = "Joins hlsl string with semantics", Author = "everyoneishappy", Tags = "Fieldtrip")]
    #endregion PluginInfo
    public class VF2DJoin : IPluginEvaluate, IDX11ResourceDataRetriever
    {
        #region fields & pins
        [Input("HLSL", IsSingle = true)]
        public IDiffSpread<string> FInHLSL;

        [Input("Custom Semantic")]
        protected Pin<IDX11RenderSemantic> FInCustomSemantic;

        [Input("Resource Semantic")]
        protected Pin<DX11Resource<IDX11RenderSemantic>> FInResourceSemantic;

        [Output("Output", IsSingle = true)]
        public ISpread<VF2D> FOutFieldTripFunction;


        [Import()]
        protected IPluginHost FHost;

        #endregion fields & pins
        public void Evaluate(int SpreadMax)
        {
            if (this.RenderRequest != null) { RenderRequest(this, this.FHost); }

            if (!(FInHLSL.IsChanged || FInCustomSemantic.IsChanged || FInResourceSemantic.IsChanged)) return;

            VF2D ftFunc = new VF2D();

            ftFunc.SetString(FInHLSL[0]);
            if (FInCustomSemantic.IsConnected) ftFunc.SetSemantics(FInCustomSemantic);
            if (FInResourceSemantic.IsConnected) ftFunc.SetResources(FInResourceSemantic);
            FOutFieldTripFunction[0] = ftFunc;
        }

        #region dx11
        public DX11RenderContext AssignedContext
        {
            get;
            set;
        }

        public event DX11RenderRequestDelegate RenderRequest;

        #endregion dx11

    }

    #region PluginInfo
    [PluginInfo(Name = "Split", Category = "VF2D", Help = "Splits function in to hlsl string and semantics", Author = "everyoneishappy", Tags = "FieldTrip")]
    #endregion PluginInfo
    public class VF2DSplit : IPluginEvaluate, IDX11ResourceHost
    {
        #region fields & pins

        [Input("Input", IsSingle = true)]
        public IDiffSpread<VF2D> FInFieldTripFunction;

        [Input("Enabled", DefaultBoolean = true, IsSingle = true)]
        public ISpread<bool> FEnabled;

        [Output("HLSL", IsSingle = true)]
        public ISpread<string> FHLSL;

        [Output("Custom Semantics")]
        public ISpread<IDX11RenderSemantic> FOutCustomSemantic;

        [Output("Resource Semantics")]
        public ISpread<DX11Resource<IDX11RenderSemantic>> FOutResourceSemantic;

        #endregion fields & pins

        public void Evaluate(int SpreadMax)
        {
            if (!FInFieldTripFunction.IsChanged || !FEnabled[0]) return;
            FOutCustomSemantic.SliceCount = 0;
            FOutResourceSemantic.SliceCount = 0;
            VF2D ftFunc = FInFieldTripFunction[0];
            if (ftFunc != null)
            {
                FHLSL[0] = ftFunc.HLSL;

                if (ftFunc.CustomSemantics.Count > 0)
                {
                    FOutCustomSemantic.AssignFrom(ftFunc.CustomSemantics);
                }

                if (ftFunc.ResourceSemantics.Count > 0)
                {
                    FOutResourceSemantic.AssignFrom(ftFunc.ResourceSemantics);
                }
            }
        }

        public void Update(DX11RenderContext context)
        {

        }

        public void Destroy(DX11RenderContext context, bool force)
        {
            for (int i = 0; i < this.FOutResourceSemantic.SliceCount; i++)
            {
                this.FOutResourceSemantic[i].Dispose(context);
            }
        }
    }

    #region PluginInfo
    [PluginInfo(Name = "Join", Category = "SF3D", Help = "Joins hlsl string with semantics", Author = "everyoneishappy", Tags = "Fieldtrip")]
    #endregion PluginInfo
    public class SF3DJoin : IPluginEvaluate, IDX11ResourceDataRetriever
    {
        #region fields & pins
        [Input("HLSL", IsSingle = true)]
        public IDiffSpread<string> FInHLSL;

        [Input("Custom Semantic")]
        protected Pin<IDX11RenderSemantic> FInCustomSemantic;

        [Input("Resource Semantic")]
        protected Pin<DX11Resource<IDX11RenderSemantic>> FInResourceSemantic;

        [Output("Output", IsSingle = true)]
        public ISpread<SF3D> FOutFieldTripFunction;


        [Import()]
        protected IPluginHost FHost;

        #endregion fields & pins
        public void Evaluate(int SpreadMax)
        {
            if (this.RenderRequest != null) { RenderRequest(this, this.FHost); }

            if (!(FInHLSL.IsChanged || FInCustomSemantic.IsChanged || FInResourceSemantic.IsChanged)) return;

            SF3D ftFunc = new SF3D();

            ftFunc.SetString(FInHLSL[0]);
            if (FInCustomSemantic.IsConnected) ftFunc.SetSemantics(FInCustomSemantic);
            if (FInResourceSemantic.IsConnected) ftFunc.SetResources(FInResourceSemantic);
            FOutFieldTripFunction[0] = ftFunc;
        }

        #region dx11
        public DX11RenderContext AssignedContext
        {
            get;
            set;
        }

        public event DX11RenderRequestDelegate RenderRequest;

        #endregion dx11

    }

    #region PluginInfo
    [PluginInfo(Name = "Split", Category = "SF3D", Help = "Splits function in to hlsl string and semantics", Author = "everyoneishappy", Tags = "FieldTrip")]
    #endregion PluginInfo
    public class SF3DSplit : IPluginEvaluate, IDX11ResourceHost
    {
        #region fields & pins

        [Input("Input", IsSingle = true)]
        public IDiffSpread<SF3D> FInFieldTripFunction;

        [Input("Enabled", DefaultBoolean = true, IsSingle = true)]
        public ISpread<bool> FEnabled;

        [Output("HLSL", IsSingle = true)]
        public ISpread<string> FHLSL;

        [Output("Custom Semantics")]
        public ISpread<IDX11RenderSemantic> FOutCustomSemantic;

        [Output("Resource Semantics")]
        public ISpread<DX11Resource<IDX11RenderSemantic>> FOutResourceSemantic;

        #endregion fields & pins

        public void Evaluate(int SpreadMax)
        {
            if (!FInFieldTripFunction.IsChanged || !FEnabled[0]) return;
            FOutCustomSemantic.SliceCount = 0;
            FOutResourceSemantic.SliceCount = 0;
            SF3D ftFunc = FInFieldTripFunction[0];
            if (ftFunc != null)
            {
                FHLSL[0] = ftFunc.HLSL;

                if (ftFunc.CustomSemantics.Count > 0)
                {
                    FOutCustomSemantic.AssignFrom(ftFunc.CustomSemantics);
                }

                if (ftFunc.ResourceSemantics.Count > 0)
                {
                    FOutResourceSemantic.AssignFrom(ftFunc.ResourceSemantics);
                }
            }
        }

        public void Update(DX11RenderContext context)
        {

        }

        public void Destroy(DX11RenderContext context, bool force)
        {
            for (int i = 0; i < this.FOutResourceSemantic.SliceCount; i++)
            {
                this.FOutResourceSemantic[i].Dispose(context);
            }
        }
    }

    #region PluginInfo
    [PluginInfo(Name = "Join", Category = "VF3D", Help = "Joins hlsl string with semantics", Author = "everyoneishappy", Tags = "Fieldtrip")]
    #endregion PluginInfo
    public class VF3DJoin : IPluginEvaluate, IDX11ResourceDataRetriever
    {
        #region fields & pins
        [Input("HLSL", IsSingle = true)]
        public IDiffSpread<string> FInHLSL;

        [Input("Custom Semantic")]
        protected Pin<IDX11RenderSemantic> FInCustomSemantic;

        [Input("Resource Semantic")]
        protected Pin<DX11Resource<IDX11RenderSemantic>> FInResourceSemantic;

        [Output("Output", IsSingle = true)]
        public ISpread<VF3D> FOutFieldTripFunction;


        [Import()]
        protected IPluginHost FHost;

        #endregion fields & pins
        public void Evaluate(int SpreadMax)
        {
            if (this.RenderRequest != null) { RenderRequest(this, this.FHost); }

            if (!(FInHLSL.IsChanged || FInCustomSemantic.IsChanged || FInResourceSemantic.IsChanged)) return;

            VF3D ftFunc = new VF3D();

            ftFunc.SetString(FInHLSL[0]);
            if (FInCustomSemantic.IsConnected) ftFunc.SetSemantics(FInCustomSemantic);
            if (FInResourceSemantic.IsConnected) ftFunc.SetResources(FInResourceSemantic);
            FOutFieldTripFunction[0] = ftFunc;
        }

        #region dx11
        public DX11RenderContext AssignedContext
        {
            get;
            set;
        }

        public event DX11RenderRequestDelegate RenderRequest;

        #endregion dx11

    }

    #region PluginInfo
    [PluginInfo(Name = "Split", Category = "VF3D", Help = "Splits function in to hlsl string and semantics", Author = "everyoneishappy", Tags = "FieldTrip")]
    #endregion PluginInfo
    public class VF3DSplit : IPluginEvaluate, IDX11ResourceHost
    {
        #region fields & pins

        [Input("Input", IsSingle = true)]
        public IDiffSpread<VF3D> FInFieldTripFunction;

        [Input("Enabled", DefaultBoolean = true, IsSingle = true)]
        public ISpread<bool> FEnabled;

        [Output("HLSL", IsSingle = true)]
        public ISpread<string> FHLSL;

        [Output("Custom Semantics")]
        public ISpread<IDX11RenderSemantic> FOutCustomSemantic;

        [Output("Resource Semantics")]
        public ISpread<DX11Resource<IDX11RenderSemantic>> FOutResourceSemantic;

        #endregion fields & pins

        public void Evaluate(int SpreadMax)
        {
            if (!FInFieldTripFunction.IsChanged || !FEnabled[0]) return;
            FOutCustomSemantic.SliceCount = 0;
            FOutResourceSemantic.SliceCount = 0;
            VF3D ftFunc = FInFieldTripFunction[0];
            if (ftFunc != null)
            {
                FHLSL[0] = ftFunc.HLSL;

                if (ftFunc.CustomSemantics.Count > 0)
                {
                    FOutCustomSemantic.AssignFrom(ftFunc.CustomSemantics);
                }

                if (ftFunc.ResourceSemantics.Count > 0)
                {
                    FOutResourceSemantic.AssignFrom(ftFunc.ResourceSemantics);
                }
            }
        }

        public void Update(DX11RenderContext context)
        {

        }

        public void Destroy(DX11RenderContext context, bool force)
        {
            for (int i = 0; i < this.FOutResourceSemantic.SliceCount; i++)
            {
                this.FOutResourceSemantic[i].Dispose(context);
            }
        }
    }

}
