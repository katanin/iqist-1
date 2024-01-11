using Documenter

ch01 = Any[
        #    "README" => "ch01/README.md",
            "What's iQIST?" => "ch01/what.md",
            "Motivation" => "ch01/motivation.md",
            "Components" => "ch01/components.md",
        #    "Features" => "ch01/feature.md",
        #    "Software architecture" => "ch01/architecture.md",
            "Policy" => "ch01/policy.md",
       ]

ch02 = Any[
        #    "README" => "ch02/README.md",
            "Obtain" => "ch02/obtain.md",
            "Uncompress" => "ch02/uncompress.md",
        #    "Directory structures" => "ch02/directory.md",
            "Compiling environment" => "ch02/envir.md",
            "Compiling system" => "ch02/system.md",
            "Explanation of make.inc" => "ch02/inc.md",
            "Build iQIST at one step" => "ch02/full.md",
        #    "Build iQIST at multiple steps" => Any[
        #        "README" => "ch02/multi.md",
        #        "Build quantum impurity solvers" => "ch02/solvers.md",
        #        "Build atomic eigenvalue problem solver" => "ch02/atomic.md",
        #        "Build auxiliary tools" => "ch02/tools.md",
        #        "Build documentations" => "ch02/docs.md",
        #    ],
       ]

ch03 = Any[
        #    "README" => "ch03/README.md",
            "Configure your system" => "ch03/config.md",
        #    "iQIST recipes" => "ch03/recipes.md",
        #    "Prepare input files" => "ch03/create.md",
            "Execute the codes" => "ch03/execute.md",
        #    "Monitor the codes" => "ch03/monitor.md",
            "Profile the codes" => "ch03/profile.md",
       ]

ch04 = Any[
        #    "README" => "ch04/README.md",
        #    "How to choose suitable quantum impurity solvers?" => "ch04/choose.md",
            "Standard input files" => Any[
        #        "README" => "ch04/input.md",
                "solver.ctqmc.in" => "ch04/in_ctqmc.md",
        #        "solver.umat.in" => "ch04/in_umat.md",
        #        "solver.eimp.in" => "ch04/in_eimp.md",
        #        "solver.anydos.in" => "ch04/in_anydos.md",
        #        "solver.ktau.in" => "ch04/in_ktau.md",
        #        "atom.cix" => "ch04/in_atom.md",
            ],
        #    "Standard output files" => Any[
        #        "README" => "ch04/output.md",
        #        "Terminal output" => "ch04/out_term.md",
        #        "solver.green.dat" => "ch04/out_green.md",
        #        "solver.fcorr.dat" => "ch04/out_fcorr.md",
        #        "solver.weiss.dat" => "ch04/out_weiss.md",
        #        "solver.hybri.dat" => "ch04/out_hybri.md",
        #        "solver.grn.dat" => "ch04/out_grn.md",
        #        "solver.frn.dat" => "ch04/out_frn.md",
        #        "solver.wss.dat" => "ch04/out_wss.md",
        #        "solver.hyb.dat" => "ch04/out_hyb.md",
        #        "solver.sgm.dat" => "ch04/out_sgm.md",
        #        "solver.ac_f.dat" => "ch04/out_ac_f.md",
        #        "solver.hist.dat" => "ch04/out_hist.md",
        #        "solver.prob.dat" => "ch04/out_prob.md",
        #        "solver.paux.dat" => "ch04/out_paux.md",
        #        "solver.nmat.dat" => "ch04/out_nmat.md",
        #        "solver.kmat.dat" => "ch04/out_kmat.md",
        #        "solver.lrmm.dat" => "ch04/out_lrmm.md",
        #        "solver.szpw.dat" => "ch04/out_szpw.md",
        #        "solver.sp_t.dat" => "ch04/out_sp_t.md",
        #        "solver.sp_w.dat" => "ch04/out_sp_w.md",
        #        "solver.ch_t.dat" => "ch04/out_ch_t.md",
        #        "solver.ch_w.dat" => "ch04/out_ch_w.md",
        #        "solver.g2ph.dat" => "ch04/out_g2ph.md",
        #        "solver.h2ph.dat" => "ch04/out_h2ph.md",
        #        "solver.v4ph.dat" => "ch04/out_v4ph.md",
        #        "solver.g2pp.dat" => "ch04/out_g2pp.md",
        #        "solver.h2pp.dat" => "ch04/out_h2pp.md",
        #        "solver.v4pp.dat" => "ch04/out_v4pp.md",
        #        "solver.diag.dat" => "ch04/out_diag.md",
        #        "solver.kernel.dat" => "ch04/out_kern.md",
        #        "solver.status.dat" => "ch04/out_stat.md",
        #    ],
            "Parameters" => Any[
        #        "README" => "ch04/parameters.md",
                "isscf" => "ch04/p_isscf.md",
        #        "issun" => "ch04/p_issun.md",
        #        "isspn" => "ch04/p_isspn.md",
        #        "isbin" => "ch04/p_isbin.md",
        #        "isort" => "ch04/p_isort.md",
        #        "issus" => "ch04/p_issus.md",
        #        "isvrt" => "ch04/p_isvrt.md",
        #        "isscr" => "ch04/p_isscr.md",
        #        "ifast" => "ch04/p_ifast.md",
        #        "itrun" => "ch04/p_itrun.md",
        #        "nband" => "ch04/p_nband.md",
        #        "nspin" => "ch04/p_nspin.md",
        #        "norbs" => "ch04/p_norbs.md",
        #        "ncfgs" => "ch04/p_ncfgs.md",
        #        "nzero" => "ch04/p_nzero.md",
        #        "niter" => "ch04/p_niter.md",
        #        "lemax" => "ch04/p_lemax.md",
        #        "legrd" => "ch04/p_legrd.md",
        #        "chmax" => "ch04/p_chmax.md",
        #        "chgrd" => "ch04/p_chgrd.md",
        #        "mkink" => "ch04/p_mkink.md",
        #        "mstep" => "ch04/p_mstep.md",
        #        "mfreq" => "ch04/p_mfreq.md",
        #        "nffrq" => "ch04/p_nffrq.md",
        #        "nbfrq" => "ch04/p_nbfrq.md",
        #        "nfreq" => "ch04/p_nfreq.md",
        #        "nsing" => "ch04/p_nsing.md",
        #        "ntime" => "ch04/p_ntime.md",
        #        "nvect" => "ch04/p_nvect.md",
        #        "nleja" => "ch04/p_nleja.md",
        #        "npart" => "ch04/p_npart.md",
        #        "nflip" => "ch04/p_nflip.md",
        #        "ntherm" => "ch04/p_ntherm.md",
        #        "nsweep" => "ch04/p_nsweep.md",
        #        "nwrite" => "ch04/p_nwrite.md",
        #        "nclean" => "ch04/p_nclean.md",
        #        "nmonte" => "ch04/p_nmonte.md",
        #        "ncarlo" => "ch04/p_ncarlo.md",
        #        "U" => "ch04/p_u.md",
        #        "Uc" => "ch04/p_uc.md",
        #        "Uv" => "ch04/p_uv.md",
        #        "Jz" => "ch04/p_jz.md",
        #        "Js" => "ch04/p_js.md",
        #        "Jp" => "ch04/p_jp.md",
        #        "lc" => "ch04/p_lc.md",
        #        "wc" => "ch04/p_wc.md",
        #        "mune" => "ch04/p_mune.md",
        #        "beta" => "ch04/p_beta.md",
        #        "part" => "ch04/p_part.md",
                "alpha" => "ch04/p_alpha.md",
            ],
       ]

ch05 = Any[
        #    "README" => "ch05/README.md",
            "Standard input files" => Any[
        #        "README" => "ch05/input.md",
                "atom.config.in" => "ch05/in_atom.md",
        #        "atom.cmat.in" => "ch05/in_cmat.md",
        #        "atom.emat.in" => "ch05/in_emat.md",
        #        "atom.tmat.in" => "ch05/in_tmat.md",
            ],
        #    "Standard output files" => Any[
        #        "README" => "ch05/output.md",
        #        "Terminal output" => "ch05/out_term.md",
        #        "solver.umat.in" => "ch05/out_umat1.md",
        #        "atom.fock.dat" => "ch05/out_fock.md",
        #        "atom.tmat.dat" => "ch05/out_tmat.md",
        #        "atom.emat.dat" => "ch05/out_emat.md",
        #        "atom.umat.dat" => "ch05/out_umat2.md",
        #        "atom.eigval.dat" => "ch05/out_val.md",
        #        "atom.eigvec.dat" => "ch05/out_vec.md",
        #        "atom.sector.dat" => "ch05/out_sector.md",
        #        "atom.cix" => "ch05/out_cix.md",
        #    ],
        #    "Parameters" => Any[
        #        "README" => "ch05/parameters.md",
        #        "ibasis" => "ch05/p_ibasis.md",
        #        "ictqmc" => "ch05/p_ictqmc.md",
        #        "icu" => "ch05/p_icu.md",
        #        "icf" => "ch05/p_icf.md",
        #        "isoc" => "ch05/p_isoc.md",
        #        "nband" => "ch05/p_nband.md",
        #        "nspin" => "ch05/p_nspin.md",
        #        "norbs" => "ch05/p_norbs.md",
        #        "ncfgs" => "ch05/p_ncfgs.md",
        #        "nmini" => "ch05/p_nmini.md",
        #        "nmaxi" => "ch05/p_nmaxi.md",
        #        "Uc" => "ch05/p_uc.md",
        #        "Uv" => "ch05/p_uv.md",
        #        "Jz" => "ch05/p_jz.md",
        #        "Js" => "ch05/p_js.md",
        #        "Jp" => "ch05/p_jp.md",
        #        "Ud" => "ch05/p_ud.md",
        #        "Jh" => "ch05/p_jh.md",
        #        "mune" => "ch05/p_mune.md",
        #        "lambda" => "ch05/p_lambda.md",
        #    ],
       ]

ch06 = Any[
        #    "README" => "ch06/README.md",
        #    "Toolbox" => Any[
        #        "README" => "ch06/toolbox.md",
        #        "toolbox/makechi" => "ch06/chi.md",
        #        "toolbox/makedos" => "ch06/dos.md",
        #        "toolbox/makekra" => "ch06/kra.md",
        #        "toolbox/makescr" => "ch06/scr.md",
        #        "toolbox/makesig" => "ch06/sig.md",
        #        "toolbox/makestd" => "ch06/std.md",
        #        "toolbox/maketau" => "ch06/tau.md",
        #        "toolbox/makeups" => "ch06/ups.md",
        #    ],
            "Scripts" => Any[
        #        "README" => "ch06/script.md",
                "u_movie.py" => "ch06/movie.md",
                "u_atomic.py" => "ch06/atomic.md",
                "u_ctqmc.py" => "ch06/ctqmc.md",
                "u_reader.py" => "ch06/reader.md",
                "u_writer.py" => "ch06/writer.md",
            ],
       ]

ch07 = Any[
        #    "README" => "ch07/README.md",
        #    "Basic applications" => Any[
        #        "README" => "ch07/basic.md",
        #        "Hello iQIST!" => "ch07/hello.md",
        #        "Mott metal-insulator transition" => "ch07/mott.md",
        #    ],
        #    "Advanced applications I: Complex systems" => Any[
        #        "README" => "ch07/complex.md",
        #        "General Coulomb interaction" => "ch07/general.md",
        #        "Spin-orbital coupling" => "ch07/soc.md",
        #        "Crystal field splitting" => "ch07/cfs.md",
        #        "Retarded interaction and dynamical screening effect" => "ch07/screening.md",
        #    ],
        #    "Advanced applications II: Accurate measurements" => Any[
        #        "README" => "ch07/accurate.md",
        #        "One-shot and self-consistent calculations" => "ch07/self.md",
        #        "Imaginary-time Green's function" => "ch07/gtau.md",
        #        "Matsubara Green's function and self-energy function" => "ch07/matsubara.md",
        #        "Spin-spin correlation function and orbital-orbital correlation function" => "ch07/chi.md",
        #        "Two-particle Green's function and vertex function" => "ch07/vertex.md",
        #    ],
        #    "Advanced applications III: Post-processing procedures" => Any[
        #        "README" => "ch07/post.md",
        #        "Analytical continuation for imaginary-time Green's function" => "ch07/mem.md",
        #        "Analytical continuation for Matsubara self-energy function" => "ch07/swing.md",
        #    ],
        #    "Practical exercises" => Any[
        #        "README" => "ch07/practical.md",
        #        "Orbital-selective Mott transition in two-band Hubbard model" => "ch07/osmt.md",
        #    ],
        #    "Code validation" => "ch07/valid.md",
            "Successful stories" => "ch07/story.md",
       ]

ch08 = Any[
            #"README" => "ch08/README.md",
            "Basic theory and methods" => Any[
                "Outline" => "ch08/basic.md",
                "Quantum impurity model" => "ch08/qim.md",
                "Principles of continuous-time quantum Monte Carlo algorithm" => "ch08/ct.md",
                "Hybridization expansion" => "ch08/hyb.md",
            ],
            "Algorithms" => Any[
        #        "README" => "ch08/algo.md",
        #        "Transition probability" => "ch08/tran.md",
        #        "Hubbard-Holstein model" => "ch08/holstein.md",
        #        "Dynamical screening effect" => "ch08/screening.md",
        #        "Physical observable" => "ch08/obs.md",
        #        "Orthogonal polynomial representation" => "ch08/ortho.md",
        #        "Kernel polynomial method" => "ch08/kpm.md",
                "Improved estimator for the self-energy function" => "ch08/sig.md",
        #        "Fast matrix update" => "ch08/fast.md",
        #        "Good quantum number, subspace, and symmetry" => "ch08/symmetry.md",
                "Truncation approximation" => "ch08/truncation.md",
                "Lazy trace evaluation" => "ch08/lazy.md",
        #        "Divide-and-conquer algorithm" => "ch08/dac.md",
        #        "Sparse matrix tricks" => "ch08/sparse.md",
                "Random number generator" => "ch08/rng.md",
                "Atomic eigenvalue solver" => "ch08/atomic.md",
                "Single particle basis" => "ch08/basis.md",
                "Spin-orbit coupling" => "ch08/soc.md",
                "Coulomb interaction matrix" => "ch08/coulomb.md",
            ],
            "Codes" => Any[
        #        "README" => "ch08/code.md",
                "Development platform" => "ch08/platform.md",
        #        "A guide to the source codes of the CT-HYB components" => "ch08/struct.md",
        #        "How to add new parameter?" => "ch08/new_param.md",
        #        "How to add new observable?" => "ch08/new_obs.md",
           ],
       ]

makedocs(
    sitename="iQIST",
    clean = false,
    authors = "Li Huang",
    format = Documenter.HTML(
        prettyurls = false,
        ansicolor = true,
        repolink = "https://github.com/huangli712/iQIST",
    ),
    remotes = nothing,
    pages = [
        "Home" => "index.md",
        "Team" => "team.md",
        "Copyright" => "copy.md",
        "Acknowledgements" => "thanks.md",
        "Introduction" => ch01,
        "Installation" => ch02,
        "Getting started" => ch03,
        "Quantum impurity solvers" => ch04,
        "Atomic eigenvalue problem solver" => ch05,
        "Auxiliary tools" => ch06,
        "iQIST in action" => ch07,
        "Inside iQIST" => ch08,
        #"Appendix" => "appendix/README.md",
        "Glossary" => "glossary.md",
    ],
)
