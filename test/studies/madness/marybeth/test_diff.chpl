use MRA;
use MadAnalytics;

def main() {
    var npt = 10;

    writeln("Mad Chapel -- Differentiation Test\n");

    var fcn  : [1..4] AFcn = (Fn_Test1():AFcn,  Fn_Test2():AFcn,  Fn_Test3():AFcn, Fn_Unity():AFcn);
    var dfcn : [1..4] AFcn = (Fn_dTest1():AFcn, Fn_dTest2():AFcn, Fn_dTest3():AFcn, Fn_dUnity():AFcn);

    for i in fcn.domain {
        writeln("** Testing function ", i);
        var F = Function(k=5, thresh=1e-5, f=fcn[i]);

        writeln("F", i, ".norm2() = ", F.norm2());

        if verbose {
            F.summarize();
            writeln("Evaluating F", i, " on [0, 1]:");
            F.evalNPT(npt);
            writeln();
        }

        writeln("Compressing F", i, " ...");
        F.compress((0,0));
        if verbose then F.summarize();

        writeln("Reconstructing F", i, " ...");
        F.reconstruct((0,0));
        writeln("F", i, ".norm2() = ", F.norm2());
        if verbose then F.summarize();

        writeln("Evaluating F", i, " on [0, 1]:");
        F.evalNPT(npt);

        writeln("\nDifferentiating F", i, " ...");
        var dF = F.diff();
        dF.f = dfcn[i]:AFcn; // Fudge it for the sake of evalNPT()
        if verbose then dF.summarize();

        writeln("\nEvaluating dF", i, " on [0, 1]:");
        dF.evalNPT(npt);

        if i < fcn.domain.dim(1).high then
            writeln("\n======================================================================\n");
    }
}
