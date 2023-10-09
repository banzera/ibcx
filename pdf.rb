
def fn(fn='') = "topmostSubform[0].Page1[0]" + fn

pdf = FillablePDF.new 'lrr.pdf'

pdf.set_field fn(".P[1].TextField2[0]"), "4008746" # Policy Number
pdf.set_field fn(".P[2].TextField2[0]"), "Bryan Banz" # Owner Name
pdf.set_field fn(".P[3].NumericField1[0]"), "500.00"
pdf.set_field fn(".P[3].TextField2[0]"), "09/2023"    #  Deduction Begin Date
pdf.set_field fn(".P[4].TextField2[0]"), "25th" # Day of Mo
pdf.set_field fn(".P[17].DateTimeField1[0]"), "08/25/2023"  # sig date
pdf.set_field fn(".TextField2[0]"), "Mid-Kansas Credit Union"  # fin inst name
pdf.set_field fn(".TextField2[1]"), "104 South Avenue B / Moundridge, KS / 67017"  # fin inst addr
pdf.set_field fn(".TextField2[2]"), "301179216"  # fin inst routing
pdf.set_field fn(".TextField2[3]"), "000583010"  # fin inst acct
pdf.set_field fn(".P[23].TextField2[0]"), "Julia J Banz" # insured name

pdf.save_as('filled.pdf')

pdf.close

