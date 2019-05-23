<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSaleReturnInvoice extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('SaleReturnInvoices', function(Blueprint $table)
		{
			$table->increments('sale_r_invoice_id');
                        $table->integer('cus_id')->default(0)->comment('can be 0 for unregister customer');
                        $table->integer('payment_type_id')->unsigned();
                        $table->double('amount', 12, 3);
                        $table->double('less_amount', 12, 3)->comment('loss amount of customer for return');
                        $table->date('date');


                        $table->integer('status')->default(1)->comment('0=Inactive, 1=Active');
                        $table->integer('year');
                        $table->integer('created_by')->unsigned();
                        $table->integer('updated_by')->nullable()->unsigned();
			$table->timestamps();
		});
                Schema::table('SaleReturnInvoices', function(Blueprint $table)
                {
                    $table->index('sale_r_invoice_id');
                    $table->foreign('payment_type_id')->references('payment_type_id')->on('PaymentTypes')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('created_by')->references('emp_id')->on('EmpInfos')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('updated_by')->references('emp_id')->on('EmpInfos')->onDelete('cascade')->onUpdate('CASCADE');
                });
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('SaleReturnInvoices');
	}

}
